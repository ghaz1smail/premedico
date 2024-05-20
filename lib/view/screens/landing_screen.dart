import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/logo.png',
            height: 200,
          ),
          const Spacer(),
          Container(
              decoration: BoxDecoration(
                  color: appConstant.primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25))),
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "lets_get_started".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: appConstant.backgroundColor,
                        fontSize: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: CustomButton(
                          onPressed: () =>
                              Get.find<AuthController>().changeType('patient'),
                          height: 60,
                          border: true,
                          title: 'patient'),
                    ),
                    CustomButton(
                        onPressed: () =>
                            Get.find<AuthController>().changeType('doctor'),
                        color: appConstant.backgroundColor,
                        textColor: appConstant.primaryColor,
                        height: 60,
                        title: 'doctor')
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
