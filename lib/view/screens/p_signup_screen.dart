import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';

import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_text_field.dart';

class PSignUpScreen extends StatelessWidget {
  const PSignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Form(
            key: controller.signUp,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView(
                children: [
                  Text(
                    "you_must_enter_your_information_to_join".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    hint: 'enter_your_name',
                    label: 'name',
                    controller: controller.name,
                    icon: Icons.person,
                    validator: controller.validateUserName,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomTextField(
                      hint: 'enter_your_email',
                      label: 'email',
                      controller: controller.email,
                      icon: Icons.mail_sharp,
                      validator: controller.emailValidation,
                    ),
                  ),
                  CustomTextField(
                    hint: 'enter_password',
                    label: 'password',
                    controller: controller.password,
                    icon: Icons.lock,
                    validator: controller.validatePass,
                    obscure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomTextField(
                      hint: 'enter_password',
                      label: 'password',
                      controller: controller.conPassword,
                      icon: Icons.lock,
                      validator: controller.validateConfirmPass,
                      obscure: true,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onPressed: controller.signingUp,
                    title: 'sign_up',
                    loading: controller.signupLoading,
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already_have_an_acccount'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.offNamed('login');
                          },
                          child: Text(
                            'login'.tr,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: appConstant.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
