import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatelessWidget {
  final UserModel userData;
  const VideoCallScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    String mergedString =
        userData.uid! + Get.find<AuthController>().userData!.uid!;

    List<String> charList = mergedString.split('');
    charList.sort();
    String sortedString = charList.join('');
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: appConstant.zegoappID,
        appSign: appConstant.zegoAppSign,
        userID: Get.find<AuthController>().userData!.uid!,
        userName: Get.find<AuthController>().userData!.name!,
        callID: sortedString,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}
