import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      totalPage: 4,
      speed: 1.8,
      finishButtonText: 'start'.tr,
      centerBackground: true,
      onFinish: () {
        getStorage.write('first', false);
        Get.offNamed('landing');
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: appConstant.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      ),
      controllerColor: appConstant.primaryColor,
      headerBackgroundColor: appConstant.backgroundColor,
      background: List.generate(
        4,
        (index) => Image.asset(
          'assets/images/p${index + 1}.png',
          height: Get.width,
          width: Get.width,
          fit: BoxFit.fill,
        ),
      ),
      pageBodies: [
        Container(
          margin: const EdgeInsets.only(bottom: 125),
          alignment: Alignment.bottomCenter,
          child: Text(
            'consult_only_with_a_doctor_you_trust'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 125),
          alignment: Alignment.bottomCenter,
          child: Text(
            'find_a_ot_of_specialist_doctor_in_one_place'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 125),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'thank_you'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appConstant.primaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'get_connect_with_our_online_consultation'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 125),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'start_now'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appConstant.primaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'where_everyone_is_here_to_help_you'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
