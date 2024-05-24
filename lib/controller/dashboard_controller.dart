import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0, bannerIndex = 0;
  List bottomItems = [Icons.home_filled, Icons.favorite_border, Icons.chat];
  var banner = [
    'https://static.vecteezy.com/system/resources/previews/021/813/966/non_2x/medical-banner-with-objects-of-laboratory-tests-and-medical-equipment-joints-brain-heart-kidneys-test-tubes-bacteria-border-vector.jpg',
    'https://cardio.com.gh/wp-content/uploads/2019/07/Medical-Banner.jpg'
  ];
  changeBannerIndex(x) {
    bannerIndex = x;
    update();
  }

  changeIndex(int x) {
    selectedIndex = x;
    update();
  }
}
