import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:premedico/forgotpassword.dart';
import 'package:premedico/notimpotant/main.dart';
import 'package:premedico/signup.dart';
import 'package:premedico/sliders.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "signup": (context) => const SignUp(title: "Sign up"),
        "login": (context) => const MyHomePage(),
        "onboarding": (context) => const MyHome(),
        "forgetpassword": (context) => const Password(title: "Password")
      },
    );
  }
}
