import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> signUp = GlobalKey();
  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      username = TextEditingController(),
      password = TextEditingController(),
      conPassword = TextEditingController();
  bool notification = false;
  String type = 'patient';
  UserModel? userData;

  changeType(x) {
    type = x;
    update();
  }

  notificationPermission() async {
    notification = getStorage.read('notification') ?? false;

    await firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true);
    firebaseMessaging.setForegroundNotificationPresentationOptions();
    if (notification) {
      if (GetPlatform.isIOS) {
        await firebaseMessaging.getAPNSToken();
      }

      firebaseMessaging.subscribeToTopic(userData!.uid!.toLowerCase());

      firebaseMessaging.getToken().then((value) {
        Get.log('token: $value');
        firestore.collection('users').doc(userData!.uid).update({
          'token': value,
          'ios': GetPlatform.isIOS,
        });
      });
    }
  }

  createAccount() async {}

  checkToken() async {
    var firstTime = getStorage.read('first') ?? true;

    if (firebaseAuth.currentUser == null) {
      await Future.delayed(const Duration(seconds: 2));
      if (firstTime) {
        Get.offNamed('onboarding');
      } else {
        Get.offNamed('landing');
      }
    } else {
      await getUserData();
    }
  }

  getUserData() async {
    await firestore.collection('users').doc().get().then((value) {
      if (value.exists) {
        userData = UserModel.fromJson(value.data()!);
      } else {
        userData = UserModel(type: '');
      }
      navigator();
    });
  }

  logOut() async {
    Get.offNamed('landing');
    firebaseAuth.signOut();
    firebaseMessaging.deleteToken();
    userData = null;
  }

  navigator() {
    switch (userData!.type) {
      case 'patient':
        // Get.offAllNamed('homeScreen');
        notificationPermission();
      case 'doctor':
      // Get.offAllNamed('spHomeScreen');
      default:
        Get.offNamed('landing');
    }
  }
}
