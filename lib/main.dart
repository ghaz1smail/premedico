import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:premedico/data/firebase_options.dart';
import 'package:premedico/controller/material_app.dart';
import 'package:premedico/data/get_initial.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetInitial().initialControllers();

  await GetStorage.init();
  Gemini.init(apiKey: appConstant.geminiKey);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  FirebaseMessaging.onMessage.listen((event) async {
    Get.log('onMessage');
    switch (event.data['type']) {
      case 'videoCall':
        break;
    }
  });
  runApp(const MyApp());
}
