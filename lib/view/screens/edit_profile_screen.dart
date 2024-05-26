import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    Get.find<AuthController>().getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'edit_profile'.tr,
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
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: Align(
                      child: Stack(
                        children: [
                          controller.imageFile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.file(
                                    controller.imageFile!,
                                    height: 75,
                                    width: 75,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : CustomImage(
                                  url: controller.userData!.image!,
                                  height: 75,
                                  width: 75,
                                  radius: 100,
                                ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: appConstant.secondaryColor,
                              child: Icon(
                                Icons.photo_camera,
                                size: 10,
                                color: appConstant.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: 'enter_your_name',
                    label: 'name',
                    controller: controller.name,
                    icon: Icons.person,
                    validator: controller.validateUserName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hint: 'enter_phone_number',
                    label: 'phone_number',
                    controller: controller.phone,
                    icon: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hint: 'date_of_birth',
                    label: 'date_of_birth',
                    controller: controller.birth,
                    icon: Icons.calendar_month,
                    onTap: () {
                      controller.selectDate();
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    onPressed: () {
                      controller.updateProfile();
                    },
                    loading: controller.loading,
                    title: 'update',
                    width: Get.width * 0.5,
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ));
  }
}
