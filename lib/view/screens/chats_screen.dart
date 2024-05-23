import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/messages_screen.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

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
          // var list = snapshot.data!.docs
          //     .map((e) => OrderModel.fromJson(e.data()))
          //     .toList();

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return ListTile(
                title: Text(data.id),
                onTap: () {
                  Get.to(() => MessagesScreen(
                      userData: UserModel.fromJson(data['userData'])));
                },
              );
            },
          );
        }
        return const CustomLoading();
      },
    ));
  }
}
