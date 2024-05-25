import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_text_field.dart';

class DSignUpScreen extends StatefulWidget {
  const DSignUpScreen({
    super.key,
  });

  @override
  State<DSignUpScreen> createState() => _DSignUpScreenState();
}

class _DSignUpScreenState extends State<DSignUpScreen> {
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
                    "join_as_a_doctor".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 20),
                    child: CustomTextField(
                      hint: 'enter_your_name',
                      label: 'name',
                      controller: controller.name,
                      icon: Icons.person,
                      validator: controller.validateUserName,
                    ),
                  ),
                  CustomTextField(
                    hint: 'enter_your_major',
                    label: 'major',
                    controller: controller.major,
                    icon: Icons.badge,
                    validator: controller.majorValidation,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomTextField(
                      hint: 'enter_years_of_experence',
                      label: 'years_of_experence',
                      controller: controller.years,
                      icon: Icons.onetwothree,
                      validator: controller.yearsValidation,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomTextField(
                      hint: 'enter_your_email',
                      label: 'email',
                      controller: controller.email,
                      icon: Icons.email,
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
                  const SizedBox(height: 40),
                  CustomButton(
                    onPressed: () {
                      controller.signingUp();
                    },
                    title: "sign_up".tr,
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
                            Get.toNamed('login');
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
