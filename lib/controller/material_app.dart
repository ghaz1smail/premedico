import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/language_controller.dart';
import 'package:premedico/data/languages.dart';
import 'package:premedico/forgotpassword.dart';
import 'package:premedico/login.dart';
import 'package:premedico/signup.dart';
import 'package:premedico/view/screens/landing_screen.dart';
import 'package:premedico/view/screens/on_boarding_screen.dart';
import 'package:premedico/view/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: Locale(Get.find<LanguageController>().getSavedLanguage()),
      translations: Languages(),
      routes: {
        "signup": (context) => const SignUp(),
        "login": (context) => const LoginScreen(),
        "onboarding": (context) => const OnBoardingScreen(),
        "forgetpassword": (context) => const Password(),
        "landing": (context) => const LandingScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
