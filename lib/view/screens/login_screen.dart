import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Form(
            key: controller.login,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: Text(
                    "welcome_back".tr,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: 'enter_your_email',
                        label: 'email',
                        controller: controller.email,
                        icon: Icons.mail_sharp,
                        validator: controller.emailValidation,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        hint: 'enter_password',
                        label: 'password',
                        controller: controller.password,
                        icon: Icons.lock,
                        validator: controller.validatePass,
                        obscure: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller.rememberMe,
                            onChanged: (e) {
                              controller.changeRemember();
                            },
                            activeColor: appConstant.primaryColor,
                          ),
                          Text(
                            'remember_me'.tr,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('forgetpassword');
                            },
                            child: Text(
                              'forget_password'.tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 70),
                        child: CustomButton(
                          onPressed: controller.signingIn,
                          title: 'login',
                          loading: controller.loginLoading,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'dont_have_an_account'.tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.offNamed(controller.type == 'doctor'
                                    ? 'd'
                                    : 'p' "signup");
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(9, 123, 100, 1),
                                ),
                              ),
                            ),
                          ],
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
                          "change_account_type".tr,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
