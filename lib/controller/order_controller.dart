import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/add_new_card_screen.dart';
import 'package:premedico/view/screens/messages_screen.dart';

class OrderController extends GetxController {
  DateTime dateTimePicker = DateTime.now();
  List<DateTime> randomTime = [];
  TextEditingController note = TextEditingController();
  double adminFee = 1;
  String paymentMethod = 'visa';
  bool orderingLoading = false;

  createOrder(UserModel doctorData) async {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    orderingLoading = true;
    update();
    if (paymentMethod == 'visa') {
      await Get.to(() => const AddNewCardScreen());
    }

    await firestore.collection('orders').doc(id).set({
      'id': id,
      'dateTime': dateTimePicker.toString(),
      'timestamp': id,
      'note': note.text,
      'paymentMethod': paymentMethod,
      'doctorData': doctorData.toJson(),
      'userData': Get.find<AuthController>().userData!.toJson()
    });

    orderingLoading = false;
    update();
    Get.off(() => MessagesScreen(
          userData: doctorData,
        ));
  }

  changePayment(x) {
    paymentMethod = x;
    update();
  }

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
