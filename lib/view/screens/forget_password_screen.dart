import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: GetBuilder<AuthController>(
        builder: (controller) {
          return Form(
            key: controller.forget,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView(
                children: [
                  Text(
                    "forget_password".tr,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "please_enter_your_email_to_reset_your_password".tr,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: controller.email,
                    keyboardType: TextInputType.text,
                    validator: controller.emailValidation,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail_sharp,
                        color: appConstant.primaryColor,
                      ),
                      hintText: "enter_your_email".tr,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'email'.tr,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: appConstant.primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          )),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () {
                      controller.resetPassword();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff007F70),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: controller.loginLoading
                          ? const CustomLoading(
                              green: false,
                              size: 50,
                            )
                          : Center(
                              child: Text(
                              "submit".tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                        child: Text(
                      "back_to_login".tr,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
