import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/language_controller.dart';
import 'package:premedico/data/get_initial.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'change_language'.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  controller.changeLanguage('en');
                },
                contentPadding: EdgeInsets.zero,
                title: const Text('English'),
                leading: Radio(
                    value: 'en',
                    activeColor: appConstant.primaryColor,
                    groupValue: controller.locale,
                    onChanged: (s) {
                      controller.changeLanguage('en');
                    }),
              ),
              ListTile(
                onTap: () {
                  Get.find<LanguageController>().changeLanguage('ar');
                },
                contentPadding: EdgeInsets.zero,
                title: const Text('اللغة العربية'),
                leading: Radio(
                    value: 'ar',
                    activeColor: appConstant.primaryColor,
                    groupValue: controller.locale,
                    onChanged: (s) {
                      controller.changeLanguage('ar');
                    }),
              ),
            ],
          ),
        ));
      },
    );
  }
}
