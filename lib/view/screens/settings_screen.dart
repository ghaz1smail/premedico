import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'settings'.tr,
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
        body: GetBuilder<AuthController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor:
                          appConstant.primaryColor.withOpacity(0.1),
                      child: Icon(Icons.lightbulb,
                          color: appConstant.primaryColor),
                    ),
                    title: Text('notifications'.tr),
                    value: controller.notification,
                    activeColor: appConstant.primaryColor,
                    onChanged: (x) {
                      controller.changeNotification();
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor:
                          appConstant.primaryColor.withOpacity(0.1),
                      child: Icon(Icons.key, color: appConstant.primaryColor),
                    ),
                    title: Text('password_manger'.tr),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor:
                          appConstant.primaryColor.withOpacity(0.1),
                      child:
                          Icon(Icons.person, color: appConstant.primaryColor),
                    ),
                    title: Text('delete_account'.tr),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
