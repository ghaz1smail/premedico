import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;
  List bottomItems = [Icons.home_filled, Icons.calendar_month, Icons.person];

  changeIndex(int x) {
    selectedIndex = x;
    update();
  }
}
