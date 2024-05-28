import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/notification_model.dart';
import 'package:premedico/view/screens/messages_screen.dart';
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
            var list = snapshot.data!.docs
                .map((e) => NotificationModel.fromJson(e.data()))
                .toList();
            if (list.isEmpty) {
              return Center(
                child: Text('no_data'.tr),
              );
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var data = list[index];
                return ListTile(
                  onTap: () {
                    Get.to(() => MessagesScreen(
                        userData: data.orderData!.userData,
                        orderData: data.orderData!));
                  },
                  leading: Icon(
                    Icons.calendar_month,
                    color: appConstant.primaryColor,
                  ),
                  title: Text(
                    data.title.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: data.title == 'reminder_tommorow' ||
                          data.title == 'change_appointment'
                      ? Text(
                          DateFormat('dd/MM/yyyy hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(data.timestamp))),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                  trailing: Text(appConstant.formatElapsedTime(data.timestamp)),
                );
              },
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }
}
