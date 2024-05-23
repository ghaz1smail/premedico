import 'dart:ui';

import 'package:dio/dio.dart';

class AppConstant {
  final Color primaryColor = const Color(0xff2B7D6E);
  final Color secondaryColor = const Color(0xff1E4759);
  final Color backgroundColor = const Color(0xffF6F6F6);

  final geminiKey = 'AIzaSyAJnr1tuyKLLBpXXUBsuTwO3Ys8q7qVuDA';
  final zegoAppSign =
      'f397e84acfbf91fd0c8d81e8bede30d06443abb97d9bc6729f29872be371f17b';
  final zegoappID = 403748782;

  sendNotification() async {
    Dio dio = Dio();
    await dio.post(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        headers: {'Content-Type': 'application/json', 'Authorization': 'key='},
      ),
      // data: {
      //   "notification": {
      //     "android_channel_id": "high_importance_channel",
      //     "body": data.body,
      //     "title": data.title,
      //     "type": data.type,
      //     "sound": "default",
      //     "priority": "high"
      //   },
      //   'data': {
      //     'id': data.id,
      //     'type': data.type,
      //     'uid': data.uid,
      //     'name': data.name,
      //     'profile': data.profile,
      //   },
      //   "to": "/topics/${uid.toLowerCase()}"
      // },
    );
  }
}
