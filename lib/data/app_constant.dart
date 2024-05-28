import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppConstant {
  final Color primaryColor = const Color(0xff2B7D6E);
  final Color secondaryColor = const Color(0xff1E4759);
  final Color backgroundColor = const Color(0xffF6F6F6);

  final geminiKey = 'AIzaSyAJnr1tuyKLLBpXXUBsuTwO3Ys8q7qVuDA';
  final zegoAppSign =
      'f397e84acfbf91fd0c8d81e8bede30d06443abb97d9bc6729f29872be371f17b';
  final zegoappID = 403748782;
  final androidGoogleMapKey = 'AIzaSyCVs68O8ytrRteAKCN9VSo4rnjjalEd-mk';

  String formatElapsedTime(time) {
    var currentTime = DateTime.now().toUtc();
    var convertTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(time)).toUtc();

    if (currentTime.isBefore(convertTime)) {
      final temp = currentTime;
      currentTime = convertTime;
      convertTime = temp;
    }

    final elapsedDuration = currentTime.difference(convertTime);

    if (elapsedDuration.inDays >= 365) {
      final years = (elapsedDuration.inDays / 365).floor();
      return '$years${years > 1 ? ' ${'years'.tr}' : ' ${'year'.tr}'}';
    } else if (elapsedDuration.inDays >= 30) {
      final months = (elapsedDuration.inDays / 30.44).floor();
      return '$months${months > 1 ? ' ${'months'.tr}' : ' ${'month'.tr}'}';
    } else if (elapsedDuration.inDays >= 7) {
      final weeks = (elapsedDuration.inDays / 7).floor();
      return '$weeks${' ${'w'.tr}'}';
    } else if (elapsedDuration.inDays > 0) {
      return '${elapsedDuration.inDays}${' ${'d'.tr}'}';
    } else if (elapsedDuration.inHours > 0) {
      return '${elapsedDuration.inHours} ${'h'.tr}';
    } else if (elapsedDuration.inMinutes > 0) {
      return '${elapsedDuration.inMinutes} ${'m'.tr}';
    } else {
      return '${elapsedDuration.inSeconds} ${'s'.tr}';
    }
  }

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
