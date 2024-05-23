import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/message_model.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/video_call_screen.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.userData});
  final UserModel userData;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<ChatMessage> messages = [];
  bool typing = false;
  Timer? _debounce;

  pickImage() async {
    // String path = '';
    // List<Media> listImagePaths = await ImagePickers.pickerPaths(
    //   galleryMode: GalleryMode.image,
    //   selectCount: 1,
    //   showGif: false,
    // );

    // if (listImagePaths.isEmpty) return;

    // setState(() {
    //   path = listImagePaths.first.path!;
    // });

    // ChatMessage m = ChatMessage(
    //     medias: [ChatMedia(url: path, fileName: path, type: MediaType.image)],
    //     customProperties: {'file': true},
    //     user: ChatUser(id: auth.userData.uid),
    //     status: MessageStatus.sent,

    //     createdAt: Timestamp.now().toDate());

    // onSendTap(m);
  }

  updateRead() {
    // firestore
    //     .collection('users')
    //     .doc(widget.userData.uid)
    //     .collection('chats')
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .collection('messages')
    //     .get()
    //     .then((messages) {
    //   messages.docs.forEach((element) async {
    //     await firestore
    //         .collection('users')
    //         .doc(widget.userData.uid)
    //         .collection('chats')
    //         .doc(firebaseAuth.currentUser!.uid)
    //         .collection('messages')
    //         .doc(element.id)
    //         .update({'seen': true});
    //   });
    // });

    // firestore
    //     .collection('users')
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .collection('chats')
    //     .doc(widget.userData.uid)
    //     .update({'clicked': true});
  }

  changeStatus(x) async {
    // await firestore
    //     .collection('users')
    //     .doc(widget.userData.uid)
    //     .collection('chats')
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .update({'typing': x});
  }

  void onTextChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    changeStatus(true);

    _debounce = Timer(const Duration(seconds: 1), () {
      changeStatus(false);
    });
  }

  onSendTap(
    ChatMessage message,
  ) {
    setState(() {
      messages.insert(0, message);
    });
    sendMessage(message);
  }

  sendMessage(ChatMessage message) async {
    String url = '', id = message.createdAt.millisecondsSinceEpoch.toString();
    bool text = message.text.isNotEmpty;
    await firestore
        .collection('users')
        .doc(Get.find<AuthController>().userData!.uid)
        .collection('chats')
        .doc(widget.userData.uid)
        .collection('messages')
        .doc(id)
        .set({
      'text': text ? message.text : url,
      'createdAt': FieldValue.serverTimestamp(),
      'authorId': Get.find<AuthController>().userData!.uid,
      'type': text ? 'text' : 'image',
      'seen': false
    });

    await firestore
        .collection('users')
        .doc(widget.userData.uid)
        .collection('chats')
        .doc(Get.find<AuthController>().userData!.uid)
        .collection('messages')
        .doc(id)
        .set({
      'text': text ? message.text : url,
      'createdAt': FieldValue.serverTimestamp(),
      'authorId': Get.find<AuthController>().userData!.uid,
      'type': text ? 'text' : 'image',
      'seen': false
    });

    firestore
        .collection('users')
        .doc(Get.find<AuthController>().userData!.uid)
        .collection('chats')
        .doc(widget.userData.uid)
        .set({
      'lastMessage': text ? message.text : 'image',
      'updatedAt': FieldValue.serverTimestamp(),
      'userData': widget.userData.toJson(),
      'typing': false,
      'clicked': true
    });

    await firestore
        .collection('users')
        .doc(widget.userData.uid)
        .collection('chats')
        .doc(Get.find<AuthController>().userData!.uid)
        .set({
      'lastMessage': text ? message.text : 'image',
      'updatedAt': FieldValue.serverTimestamp(),
      'userData': Get.find<AuthController>().userData!.toJson(),
      'typing': false,
      'clicked': false
    });
  }

  loadData(List<MessageModel> x) async {
    for (var element in x) {
      if (!messages
          .map((e) => e.createdAt.millisecondsSinceEpoch)
          .contains(element.timestamp!.toDate().millisecondsSinceEpoch)) {
        messages.insert(
            0,
            ChatMessage(
                // medias: [
                //   if (element.type != 'text')
                //     ChatMedia(
                //         url: element.text,
                //         fileName: '${element.id}.png',
                //         type: MediaType.image),
                // ],
                customProperties: {
                  'type': element.type,
                  'id': element.id,
                  'file': false
                },
                user: ChatUser(id: element.authorId),
                status: element.seen ? MessageStatus.read : MessageStatus.sent,
                text: element.type == 'text' ? element.text : '',
                createdAt: element.timestamp!.toDate()));
      }
    }

    updateRead();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => VideoCallScreen(
                      userData: widget.userData,
                    ));
              },
              icon: const Icon(
                Icons.phone,
                color: Colors.black,
              ))
        ],
        title: Text(
          widget.userData.name!,
          style: const TextStyle(
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: firestore
              .collection('users')
              .doc(Get.find<AuthController>().userData!.uid)
              .collection('chats')
              .doc(widget.userData.uid)
              .collection('messages')
              .orderBy('createdAt')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> data = snapshot.data!.docs
                  .map((doc) => MessageModel.fromJson(doc.data(), doc.id))
                  .toList();

              loadData(data);

              return StreamBuilder(
                  stream: firestore
                      .collection('users')
                      .doc(Get.find<AuthController>().userData!.uid)
                      .collection('chats')
                      .doc(widget.userData.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data?.data();

                      if (data != null) {
                        typing = data['typing'];
                      }
                    }

                    return DashChat(
                      typingUsers: [
                        if (typing)
                          ChatUser(
                            id: widget.userData.uid!,
                            firstName: widget.userData.name,
                          ),
                      ],
                      messageOptions: MessageOptions(
                        messageTimeBuilder: (message, isOwnMessage) =>
                            isOwnMessage
                                ? Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          DateFormat.jm()
                                              .format(message.createdAt),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        if (message.status ==
                                            MessageStatus.read)
                                          const Icon(
                                            Icons.done_all,
                                            color: Colors.white,
                                            size: 12,
                                          )
                                      ],
                                    ))
                                : Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                        DateFormat.jm()
                                            .format(message.createdAt),
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white)),
                                  ),
                        textColor: Colors.white,
                        bottom: (message, previousMessage, nextMessage) =>
                            message.text.isEmpty &&
                                    message.user.id ==
                                        Get.find<AuthController>().userData!.uid
                                ? Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat.jm()
                                              .format(message.createdAt),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        if (message.status ==
                                            MessageStatus.read)
                                          const Icon(
                                            Icons.done_all,
                                            color: Colors.green,
                                            size: 12,
                                          )
                                      ],
                                    ))
                                : Container(),
                        containerColor: appConstant.secondaryColor,
                        currentUserContainerColor: appConstant.primaryColor,
                        showOtherUsersName: false,
                        showOtherUsersAvatar: false,
                        showTime: true,
                        onLongPressMessage: (p0) {
                          Clipboard.setData(ClipboardData(text: p0.text));
                        },
                      ),
                      inputOptions: InputOptions(
                        inputDecoration:
                            defaultInputDecoration(hintText: 'type_message'.tr),
                        inputToolbarMargin: EdgeInsets.zero,
                        inputToolbarPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        onTextChange: (value) {
                          onTextChanged();
                        },
                      ),
                      currentUser: ChatUser(
                          id: Get.find<AuthController>().userData!.uid!),
                      onSend: (ChatMessage m) {
                        ChatMessage x = ChatMessage(
                            text: m.text,
                            user: ChatUser(
                                id: Get.find<AuthController>().userData!.uid!),
                            status: MessageStatus.sent,
                            createdAt: Timestamp.now().toDate());
                        onSendTap(x);
                      },
                      messages: messages,
                    );
                  });
            }

            return const Center(child: CustomLoading());
          }),
    );
  }
}
