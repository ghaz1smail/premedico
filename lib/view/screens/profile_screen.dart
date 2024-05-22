import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my_profile'.tr,
          style: TextStyle(
              color: appConstant.primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Column(
              children: [
                CustomImage(
                  url: controller.userData!.image!,
                  height: 100,
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Text(
                    controller.userData!.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.edit, color: appConstant.primaryColor),
                  ),
                  title: Text('edit_profile'.tr),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.favorite_border,
                        color: appConstant.primaryColor),
                  ),
                  title: Text('favorites'.tr),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.lock, color: appConstant.primaryColor),
                  ),
                  title: Text('privacy_policy'.tr),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed('settings');
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.1),
                    child:
                        Icon(Icons.settings, color: appConstant.primaryColor),
                  ),
                  title: Text('settings'.tr),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.question_mark,
                        color: appConstant.primaryColor),
                  ),
                  title: Text('help'.tr),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    controller.logOut();
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.logout, color: appConstant.primaryColor),
                  ),
                  title: Text('logout'.tr),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
