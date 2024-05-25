import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/language_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/data/languages.dart';
import 'package:premedico/view/screens/ai_chat_screen.dart';
import 'package:premedico/view/screens/call_ambulance_screen.dart';
import 'package:premedico/view/screens/d_signup_screen.dart';
import 'package:premedico/view/screens/edit_profile_screen.dart';
import 'package:premedico/view/screens/forget_password_screen.dart';
import 'package:premedico/view/screens/doctor_dashboard_screen.dart';
import 'package:premedico/view/screens/hospitals_screen.dart';
import 'package:premedico/view/screens/login_screen.dart';
import 'package:premedico/view/screens/notifications_screen.dart';
import 'package:premedico/view/screens/orders_screen.dart';
import 'package:premedico/view/screens/patient_dashboard_screen.dart';
import 'package:premedico/view/screens/p_signup_screen.dart';
import 'package:premedico/view/screens/landing_screen.dart';
import 'package:premedico/view/screens/on_boarding_screen.dart';
import 'package:premedico/view/screens/settings_screen.dart';
import 'package:premedico/view/screens/splash_screen.dart';
import 'package:premedico/view/screens/surgery_package_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: false,
          primaryColor: appConstant.primaryColor,
          scaffoldBackgroundColor: appConstant.backgroundColor,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: appConstant.backgroundColor,
              elevation: 0)),
      locale: Locale(Get.find<LanguageController>().getSavedLanguage()),
      translations: Languages(),
      routes: {
        "psignup": (context) => const PSignUpScreen(),
        "dsignup": (context) => const DSignUpScreen(),
        "login": (context) => const LoginScreen(),
        "notifications": (context) => const NotificationsScreen(),
        "patient": (context) => const PatientDashboardScreen(),
        "doctor": (context) => const DoctorDashboardScreen(),
        "onboarding": (context) => const OnBoardingScreen(),
        "forgetpassword": (context) => const ForgetPasswordScreen(),
        "landing": (context) => const LandingScreen(),
        "callAmbulance": (context) => const CallAmbulanceScreen(),
        "surgeryPackage": (context) => const SurgeryPackageScreen(),
        "hospitals": (context) => const HospitalsScreen(),
        "settings": (context) => const SettingsScreen(),
        "ai": (context) => const AiChatScreen(),
        "ordersScreen": (context) => const OrdersScreen(),
        "editProfile": (context) => const EditProfileScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
