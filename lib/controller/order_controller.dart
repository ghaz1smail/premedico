import 'dart:math';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderController extends GetxController {
  DateTime dateTimePicker = DateTime.now();
  List<DateTime> randomTime = [];

  pickRandomTime() {
    Random random = Random();
    randomTime.clear();
    for (int i = 0; i < 9; i++) {
      int hour = random.nextInt(24);
      int minute = random.nextInt(60);
      randomTime.add(DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, hour, minute));
    }
  }

  changeDate(DateTime newDateTimePicker) {
    dateTimePicker = DateTime(
      newDateTimePicker.year,
      newDateTimePicker.month,
      newDateTimePicker.day,
      dateTimePicker.hour,
      dateTimePicker.minute,
    );
    update();
  }

  changeTime(DateTime newDateTimePicker) {
    dateTimePicker = DateTime(
      dateTimePicker.year,
      dateTimePicker.month,
      dateTimePicker.day,
      newDateTimePicker.hour,
      newDateTimePicker.minute,
    );
    update();
  }
}
