import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/language_bottom_sheet.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: Get.width * 0.75,
        child: GetBuilder<AuthController>(
          builder: (controller) {
            return SafeArea(
              child: Column(
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        Get.toNamed('editProfile');
                      },
                      child: CustomImage(
                        url: controller.userData!.image!,
                      ),
                    ),
                    title: Text(
                      controller.userData!.name!,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      customBottomSheet(const LanguageBottomSheet());
                    },
                    leading: CircleAvatar(
                      backgroundColor:
                          appConstant.primaryColor.withOpacity(0.1),
                      child:
                          Icon(Icons.language, color: appConstant.primaryColor),
                    ),
                    title: Text('change_language'.tr),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          appConstant.primaryColor.withOpacity(0.1),
                      child: Icon(Icons.question_mark,
                          color: appConstant.primaryColor),
                    ),
                    title: Text('help'.tr),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed('settings');
                    },
                    leading: CircleAvatar(
                      backgroundColor:
                          appConstant.primaryColor.withOpacity(0.1),
                      child:
                          Icon(Icons.settings, color: appConstant.primaryColor),
                    ),
                    title: Text('settings'.tr),
                  ),
                  ListTile(
                    onTap: () {
                      controller.logOut();
                    },
                    leading: CircleAvatar(
                      backgroundColor:
                          appConstant.primaryColor.withOpacity(0.1),
                      child:
                          Icon(Icons.logout, color: appConstant.primaryColor),
                    ),
                    title: Text('logout'.tr),
                  )
                ],
              ),
            );
          },
        ));
  }
}
