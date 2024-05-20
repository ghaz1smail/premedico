import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> signUp = GlobalKey();
  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      address = TextEditingController(),
      city = TextEditingController(),
      phone = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  String phoneCode = 'JO';
  bool loginLoading = false,
      newUser = false,
      first = true,
      verifyLoding = false,
      createLoading = false,
      carTypesLoading = false;
  // User userData = User();

  createAccount() async {
    // createLoading = true;
    // update();

    // var response = await http
    //     .post(Uri.parse(appConstant.baseUrlv2 + appConstant.createAccount),
    //         body: json.encode({
    //           "car_type": selectedType,
    //           "phone": userData.phone,
    //           "name": name.text,
    //           "email": email.text,
    //           "city_id": '1978',
    //           "country_id": '111',
    //           "user_type": "customer"
    //         }),
    //         headers: {'Content-Type': 'application/json'});

    // if (response.statusCode == 200) {
    //   Get.log(response.body);
    //   var body = json.decode(response.body) as Map;

    //   userData = User.fromJson(body['data']['user']);
    //   getStorage.write('token', userData.token);
    //   createLoading = false;

    //   navigator();
    // } else {
    //   createLoading = false;

    //   Get.log(response.body);
    //   Get.log(response.statusCode.toString());
    // }
    // update();
  }

  checkToken() async {
    await Future.delayed(const Duration(seconds: 2));
    var firstTime = getStorage.read('first') ?? true;
    if (firstTime) {
      Get.offNamed('onboarding');
    } else {
      Get.offNamed('landing');
    }
    // userData.token = getStorage.read('token') ?? '';
    // Get.log(userData.token.toString());
    // Get.find<LanguageController>().locale = Get.locale!.languageCode;
    // if (userData.token!.isNotEmpty) {
    //   await getUserData();
    //   await getCarTypes();
    // } else {
    //   await Future.delayed(const Duration(milliseconds: 500));

    // }
  }

  getUserData() async {
    // var response = await http.get(
    //     Uri.parse(appConstant.baseUrl + appConstant.viewAccount),
    //     headers: {'Authorization': 'Bearer ${userData.token}'});

    // if (response.statusCode == 200) {
    //   Get.log(response.body);
    //   var data = UserModel.fromJson(json.decode(response.body));

    //   if (data.message == 'success') {
    //     userData = data.user!;
    //     navigator();
    //   } else {
    //     Get.offNamed('loginScreen');
    //   }
    // } else {
    //   Get.log(response.statusCode.toString() +
    //       appConstant.baseUrl +
    //       appConstant.viewAccount);
    //   Get.offNamed('loginScreen');
    // }
  }

  logOut() async {
    // getStorage.remove('token');
    // Get.offAllNamed('loginScreen');
    // try {
    //   await http.get(Uri.parse(appConstant.baseUrl + appConstant.logout),
    //       headers: {'Authorization': 'Bearer ${userData.token}'});
    // } finally {}
  }

  navigator() {
    // saveDeviceDetails();
    // switch (userData.type!) {
    //   case 'customer':
    //     Get.offAllNamed('homeScreen');
    //   case 'service_provider':
    //     Get.offAllNamed('spHomeScreen');
    //   default:
    //     Get.offNamed('loginScreen');
    // }
  }
}
