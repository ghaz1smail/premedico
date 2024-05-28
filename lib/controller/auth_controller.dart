import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/dashboard_controller.dart';
import 'package:premedico/controller/functions_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/hospital_model.dart';
import 'package:premedico/model/user_model.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> signUp = GlobalKey(),
      login = GlobalKey(),
      forget = GlobalKey();
  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      username = TextEditingController(),
      password = TextEditingController(),
      birth = TextEditingController(),
      major = TextEditingController(),
      phone = TextEditingController(),
      years = TextEditingController(),
      conPassword = TextEditingController();
  bool notification = false,
      loading = false,
      signupLoading = false,
      loginLoading = false,
      rememberMe = false;
  DateTime date = DateTime.now();
  String type = 'patient';
  UserModel? userData;
  HospitalModel? hospitalData;
  File? imageFile;

  getProfileData() {
    loading = true;

    name.text = userData!.name!;
    phone.text = userData!.phone ?? '';
    date = DateTime.parse(userData!.birth ?? DateTime.now().toString());
    birth.text = DateFormat.yMMMMd().format(date);
    loading = false;
  }

  selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      birth.text = DateFormat.yMMMMd().format(picked);
      date = picked;

      update();
    }
  }

  updateProfile() async {
    loading = true;
    var url = '';
    update();
    if (imageFile != null) {
      while (url.isEmpty) {
        url = await firebaseStorage
            .ref()
            .child('users/${userData!.uid}')
            .getDownloadURL();
      }
    }
    userData!.name = name.text;
    userData!.phone = phone.text;
    userData!.image = url;

    await firestore.collection('users').doc(userData!.uid).update({
      'name': name.text,
      'phone': phone.text,
      'image': url,
      'birth': date.toIso8601String()
    });

    loading = false;
    Get.back();
  }

  pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
      await firebaseStorage.ref().child('users/${userData!.uid}').putData(
          File(pickedFile.path).readAsBytesSync(),
          SettableMetadata(contentType: 'image/png'));
    }
  }

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

  changeNotification() {
    notification = !notification;
    update();
    if (notification) {
      firebaseMessaging.subscribeToTopic(userData!.uid!.toLowerCase());
    } else {
      firebaseMessaging.unsubscribeFromTopic(userData!.uid!.toLowerCase());
    }
  }

  createAccount() async {
    await firestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
      'name': name.text,
      'email': email.text,
      'username': username.text,
      'favorites': [],
      'image': '',
      'gender': '',
      'birth': '',
      'phone': '',
      'bio': '',
      'rate': '0',
      'price': '0',
      'online': true,
      'uid': firebaseAuth.currentUser!.uid,
      'type': type,
      'years': years.text,
      'major': major.text,
      if (type == 'doctor') 'hospital': hospitalData!.toJson()
    }).then((value) {
      userData = UserModel.fromJson({
        'name': name.text,
        'email': email.text,
        'username': username.text,
        'favorites': [],
        'image': '',
        'gender': '',
        'birth': '',
        'phone': '',
        'bio': '',
        'rate': '0',
        'price': '0',
        'online': true,
        'uid': firebaseAuth.currentUser!.uid,
        'type': type,
        'years': years.text,
        'major': major.text,
        if (type == 'doctor') 'hospital': hospitalData!.toJson()
      });
      if (type == 'doctor') {
        firestore.collection('hospitals').doc(hospitalData!.id).update({
          'users': FieldValue.arrayUnion([firebaseAuth.currentUser!.uid])
        });
      }
    });
  }

  checkToken() async {
    var firstTime = getStorage.read('first') ?? true,
        emailx = getStorage.read('email');
    if (emailx != null) {
      email.text = emailx;
      rememberMe = true;
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
    Get.find<FunctionsController>().checkAppointments();
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
    var emailx = getStorage.read('email');
    if (emailx != null) {
      email.text = emailx;
      rememberMe = true;
    }
    name.clear();
    phone.clear();
    Get.offNamed('landing');
    firebaseAuth.signOut();
    firebaseMessaging.deleteToken();
    userData = null;
    Get.find<DashboardController>().selectedIndex = 0;
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

  String? majorValidation(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_major".tr;
    }
    return null;
  }

  String? yearsValidation(String? value) {
    if (value!.isEmpty) {
      return "please_enter_years_of_experence".tr;
    }
    return null;
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
    if (value!.length < 6 || value.isEmpty) {
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
