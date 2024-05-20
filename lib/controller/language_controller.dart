import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';

class LanguageController extends GetxController {
  String locale = 'en';

  String getSavedLanguage() {
    final cachedLanguageCode = getStorage.read('locale');

    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return 'en';
    }
  }

  void changeLanguage(String languageCode) {
    getStorage.write('locale', languageCode);
    Get.updateLocale(Locale(languageCode));
    locale = languageCode;
    update();
  }
}
