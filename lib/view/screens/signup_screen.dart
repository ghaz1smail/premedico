import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  TextFormField(
                    controller: controller.username,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.person_add_sharp,
                        size: 18,
                      ),
                      hintText: "enter_your_username".tr,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'username'.tr,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                    ),
                    validator: _validateUserName,
                  ),
                  TextFormField(
                    controller: controller.email,
                    keyboardType: TextInputType.text,
                    validator: _emailValidation,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mail_sharp,
                        size: 18,
                      ),
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.password,
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          size: 18,
                        ),
                        hintText: "enter_password".tr,
                        hintStyle: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 145, 138, 138),
                        ),
                        labelText: 'password'.tr,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ))),
                    obscureText: true,
                    validator: _validatePass,
                  ),
                  TextFormField(
                    validator: _validatePass,
                    controller: controller.conPassword,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.password,
                        size: 18,
                      ),
                      hintText: "confirm_your_password".tr,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'confirm_password'.tr,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "choose_user".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        onTap: () {
                          controller.changeType('patient');
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 3, color: Colors.grey),
                            color: controller.type == 'patient'
                                ? appConstant.primaryColor
                                : appConstant.backgroundColor,
                          ),
                          child: Text('patient'.tr,
                              style: TextStyle(
                                  color: controller.type == 'patient'
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        onTap: () {
                          controller.changeType('doctor');
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey),
                            shape: BoxShape.circle,
                            color: controller.type == 'doctor'
                                ? appConstant.primaryColor
                                : appConstant.backgroundColor,
                          ),
                          child: Text('doctor'.tr,
                              style: TextStyle(
                                  color: controller.type == 'doctor'
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      try {
                        await firebaseAuth.createUserWithEmailAndPassword(
                          email: controller.email.text,
                          password: controller.password.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          // print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          // print('The account already exists for that email.');
                        }
                      } catch (e) {
                        // print(e);
                      }
                    },
                    color: appConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
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
                            Navigator.of(context).pushNamed("login");
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

  String? _emailValidation(String? value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!)) {
      return "please_enter_a_valid_email".tr;
    }
    return null;
  }

  String? _validatePass(String? value) {
    if (value!.length <= 8 || value.isEmpty) {
      return 'password_must_not_be_at_least_8_charaters'.tr;
    }
    return null;
  }

  String? _validateUserName(String? value) {
    if (value!.length < 3) {
      return 'please_enter_username_at_least_3_characters'.tr;
    }
    return null;
  }
}
