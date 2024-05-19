import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 403748782,
        appSign:
            'f397e84acfbf91fd0c8d81e8bede30d06443abb97d9bc6729f29872be371f17b',
        userID: GetPlatform.isIOS ? '1' : '2',
        userName: 'Ghazi',
        callID: '1',
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}
