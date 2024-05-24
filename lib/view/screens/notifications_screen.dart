import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'notifications'.tr,
            style: TextStyle(
                color: appConstant.primaryColor, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))),
      body: StreamBuilder(
        stream: firestore
            .collection('users')
            .doc(Get.find<AuthController>().userData!.uid)
            .collection('notifications')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) {
                return Container();
              },
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }
}
