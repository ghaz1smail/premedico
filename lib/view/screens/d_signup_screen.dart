import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/hospital_model.dart';
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
                    child: StreamBuilder(
                      stream: firestore.collection('hospitals').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var list = snapshot.data!.docs
                              .map((e) => HospitalModel.fromJson(e.data()));
                          return Container(
                            height: 55,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(
                                    color: appConstant.primaryColor)),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              hint: Text(
                                "pick_hospital".tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              padding: EdgeInsets.zero,
                              value: controller.hospitalData?.id,
                              onChanged: (value) {
                                setState(() {
                                  controller.hospitalData!.id = value;
                                });
                              },
                              items: list
                                  .map((value) => DropdownMenuItem(
                                      onTap: () {
                                        setState(() {
                                          controller.hospitalData = value;
                                        });
                                      },
                                      value: value.id,
                                      child: Text(value.name!)))
                                  .toList(),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
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
                      if (controller.hospitalData != null) {
                        controller.signingUp();
                      } else {
                        Get.showSnackbar(GetSnackBar(
                          snackStyle: SnackStyle.FLOATING,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 50),
                          borderRadius: 10,
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.white,
                          boxShadows: const [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 0.1,
                                color: Colors.black12)
                          ],
                          messageText: Text(
                            'please_select_hospital'.tr,
                            textAlign: TextAlign.center,
                          ),
                          titleText: Text(
                            'error'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: appConstant.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          snackPosition: SnackPosition.TOP,
                        ));
                      }
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
