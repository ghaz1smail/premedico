import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/controller/language_controller.dart';
import 'package:premedico/data/app_constant.dart';

class GetInitial {
  initialControllers() {
    Get.put(LanguageController());
    Get.put(AuthController());
    // Get.put(DashboardController());
    // Get.put(NotificationController());
    // Get.put(PackageController());
    // Get.put(OfferController());
    // Get.put(OrderController());
    // Get.put(CouponsController());
    // Get.put(BalanceController());
    // Get.put(ArticlesController());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}

AppConstant appConstant = AppConstant();
final getStorage = GetStorage();

Color colorCompute(color) {
  return Color(int.parse('0xff$color')).computeLuminance() > 0.5
      ? Colors.black
      : Colors.white;
}

customBottomSheet(Widget child) {
  Get.bottomSheet(Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
    child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [SafeArea(child: child)]),
  ));
}
