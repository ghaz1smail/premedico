import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_loading.dart';

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
                    "you_must_enter_your_information_to_join".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    autocorrect: false,
                    controller: controller.name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: appConstant.primaryColor,
                      ),
                      hintText: "enter_your_name".tr,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'name'.tr,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
                    validator: controller.validateUserName,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
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
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: controller.password,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: appConstant.primaryColor,
                        ),
                        hintText: "enter_password".tr,
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 145, 138, 138),
                        ),
                        labelText: 'password'.tr,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
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
                        ))),
                    obscureText: true,
                    validator: controller.validatePass,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      autocorrect: false,
                      validator: controller.validateConfirmPass,
                      controller: controller.conPassword,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.password,
                          color: appConstant.primaryColor,
                        ),
                        hintText: "confirm_your_password".tr,
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 145, 138, 138),
                        ),
                        labelText: 'confirm_password'.tr,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
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
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 40),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      controller.signingUp();
                    },
                    color: appConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: controller.signupLoading
                        ? const CustomLoading(
                            green: false,
                            size: 50,
                          )
                        : Text(
                            "sign_up".tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          ),
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
