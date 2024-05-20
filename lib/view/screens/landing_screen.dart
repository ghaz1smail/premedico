import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';

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
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Get.offNamed("login");
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: appConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "login".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: appConstant.backgroundColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Get.offNamed("signup");
                      },
                      color: appConstant.backgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "sign_up".tr,
                        style: TextStyle(
                          color: appConstant.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
