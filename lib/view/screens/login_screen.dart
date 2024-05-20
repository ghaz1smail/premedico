import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Form(
            key: controller.login,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                    child: const Text(
                      "You must sign in to join ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 35, left: 20, right: 30),
                    child: Column(
                      children: <Widget>[
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
                          height: 20,
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
                                  borderSide: BorderSide(
                                      color: appConstant.primaryColor),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('forgetpassword');
                              },
                              child: Text(
                                'forget_password'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            controller.signingIn();
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
                                    "login".tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
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
                                'dont_have_an_account'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(controller.type == 'doctor'
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
          ),
        );
      },
    ));
  }
}
