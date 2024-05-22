import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_storage/get_storage.dart';
import 'package:premedico/data/firebase_options.dart';
import 'package:premedico/controller/material_app.dart';
import 'package:premedico/data/get_initial.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetInitial().initialControllers();

  await GetStorage.init();
  Gemini.init(apiKey: appConstant.geminiKey);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
