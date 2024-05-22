import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final Gemini gemini = Gemini.instance;

  final ChatUser currentUser = ChatUser(
    id: '1',
    firstName: Get.find<AuthController>().userData!.name,
  );

  final ChatUser gptChatUser = ChatUser(id: '2', firstName: 'AI_assistant'.tr);

  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatUser> typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'AI_assistant'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))),
      body: DashChat(
          currentUser: currentUser,
          typingUsers: typingUsers,
          inputOptions: const InputOptions(
            autocorrect: false,
          ),
          messageListOptions: MessageListOptions(
            typingBuilder: (user) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${user.firstName.toString()} ${'typing'.tr}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          messageOptions: MessageOptions(
            showOtherUsersName: false,
            avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) => Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.smart_toy,
                  color: appConstant.primaryColor,
                )),
          ),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: messages),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      messages = [m, ...messages];
      typingUsers = [gptChatUser];
    });
    try {
      String question = m.text;

      gemini
          .streamGenerateContent(
        question,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == gptChatUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: gptChatUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      }).onDone(() {
        setState(() {
          typingUsers = [];
        });
      });
    } catch (e) {
      //
    }
  }
}
