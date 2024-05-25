import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/chat_model.dart';
import 'package:premedico/view/screens/messages_screen.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: firestore
          .collection('users')
          .doc(Get.find<AuthController>().userData!.uid)
          .collection('chats')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = snapshot.data!.docs
              .map((e) => ChatModel.fromJson(e.data()))
              .toList();

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = list[index];

                return chatWidget(data);
              },
            ),
          );
        }
        return const CustomLoading();
      },
    ));
  }

  Widget chatWidget(ChatModel data) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: CustomImage(
            url: data.userData.image ?? '',
            radius: 10,
          ),
          subtitle: Text(data.lastMessage),
          trailing: !data.clicked
              ? Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: appConstant.secondaryColor,
                )
              : null,
          title: Text(data.userData.name ?? ''),
          onTap: () {
            Get.to(() => MessagesScreen(userData: data.userData));
            firestore
                .collection('users')
                .doc(Get.find<AuthController>().userData!.uid)
                .collection('chats')
                .doc(data.userData.uid)
                .update({'clicked': true});
          },
        ),
      ),
    );
  }
}
