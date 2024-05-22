import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> signUp = GlobalKey(),
      login = GlobalKey(),
      forget = GlobalKey();
  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      username = TextEditingController(),
      password = TextEditingController(),
      conPassword = TextEditingController();
  bool notification = false,
      signupLoading = false,
      loginLoading = false,
      rememberMe = false;
  String type = 'patient';
  UserModel? userData;

  resetPassword() async {
    if (!forget.currentState!.validate()) {
      return;
    }
    loginLoading = true;
    update();

    try {
      await firebaseAuth
          .sendPasswordResetEmail(email: email.text)
          .then((value) {
        Get.showSnackbar(GetSnackBar(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          message: 'reset_password_link_sent_to_email'.tr,
          duration: const Duration(seconds: 3),
          borderRadius: 25,
        ));
      });
    } on FirebaseAuthException {
      Get.defaultDialog(
          title: 'error_occured'.tr,
          titlePadding: const EdgeInsets.all(20),
          content: Text('please_try_again_later'.tr));
    } finally {
      loginLoading = false;
      update();
    }
  }

  changeRemember() {
    rememberMe = !rememberMe;
    update();
  }

  signingIn() async {
    if (!login.currentState!.validate() || loginLoading) {
      return;
    }
    loginLoading = true;
    update();
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) async {
        if (rememberMe) {
          getStorage.write('email', email.text);
        } else {
          getStorage.remove('email');
        }
        await getUserData();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: 'error_occured'.tr, content: Text('wrong_password'.tr));
      } else if (e.code == 'user-not-found') {
        Get.defaultDialog(
            title: 'error_occured'.tr,
            titlePadding: const EdgeInsets.all(20),
            content: Text('user_not_found'.tr));
      } else {
        Get.defaultDialog(
            title: 'error_occured'.tr,
            titlePadding: const EdgeInsets.all(20),
            content: Text('please_try_again_later'.tr));
      }
    } finally {
      loginLoading = false;
      update();
    }
  }

  signingUp() async {
    if (!signUp.currentState!.validate() || signupLoading) {
      return;
    }
    signupLoading = true;
    update();
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) async {
        await createAccount();
        navigator();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.defaultDialog(
            title: 'error_occured'.tr, content: Text('week_password'.tr));
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
            title: 'error_occured'.tr,
            titlePadding: const EdgeInsets.all(20),
            content: Text('email_already_in_use'.tr));
      } else {
        Get.defaultDialog(
            title: 'error_occured'.tr,
            titlePadding: const EdgeInsets.all(20),
            content: Text('please_try_again_later'.tr));
      }
    } finally {
      signupLoading = false;
      update();
    }
  }

  changeType(x) {
    type = x;
    Get.toNamed("login");
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

  createAccount() async {
    await firestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
      'name': name.text,
      'email': email.text,
      'username': username.text,
      'image': '',
      'type': type,
    }).then((value) {
      userData = UserModel(
          name: name.text,
          email: email.text,
          image: '',
          type: type,
          uid: firebaseAuth.currentUser!.uid);
    });
  }

  checkToken() async {
    var firstTime = getStorage.read('first') ?? true,
        emailx = getStorage.read('email');
    if (emailx != null) {
      email.text = emailx;
    }
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
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
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
        Get.offAllNamed('patient');
        notificationPermission();
      case 'doctor':
        Get.offAllNamed('doctor');
        notificationPermission();
      default:
        Get.offNamed('landing');
    }
    email.clear();
    password.clear();
    name.clear();
    password.clear();
    conPassword.clear();
  }

  String? emailValidation(String? value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!)) {
      return "please_enter_a_valid_email".tr;
    }
    return null;
  }

  String? validatePass(String? value) {
    if (value!.length < 8 || value.isEmpty) {
      return 'password_must_not_be_at_least_8_charaters'.tr;
    }
    return null;
  }

  String? validateConfirmPass(String? value) {
    var pass = Get.find<AuthController>().password.text;
    if (value != pass) {
      return 'passwords_not_match'.tr;
    }
    return null;
  }

  String? validateUserName(String? value) {
    if (value!.length < 3) {
      return 'please_enter_your_name'.tr;
    }
    return null;
  }
}
