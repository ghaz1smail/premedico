import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/order_model.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/add_new_card_screen.dart';
import 'package:premedico/view/screens/messages_screen.dart';

class OrderController extends GetxController {
  DateTime dateTimePicker = DateTime.now();
  List<DateTime> randomTime = [];
  TextEditingController note = TextEditingController();
  double adminFee = 1;
  String paymentMethod = 'visa';
  bool orderingLoading = false, done = false;
  SchedulingModel? scheduling;

  createOrder(UserModel doctorData) async {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    orderingLoading = true;
    update();
    if (paymentMethod == 'visa') {
      await Get.to(() => const AddNewCardScreen());
    }
    if (done || paymentMethod == 'cash') {
      await firestore.collection('orders').doc(id).set({
        'id': id,
        'dateTime': dateTimePicker.toString(),
        'timestamp': id,
        'note': note.text,
        'paymentMethod': paymentMethod,
        'amount': (doctorData.price ?? 0 + adminFee).toString(),
        'doctorData': doctorData.toJson(),
        'userData': Get.find<AuthController>().userData!.toJson()
      });
      await firestore.collection('users').doc(doctorData.uid).update({
        'scheduling': FieldValue.arrayRemove([scheduling!.toJson()])
      });
      scheduling!.user = Get.find<AuthController>().userData!.uid;
      await firestore.collection('users').doc(doctorData.uid).update({
        'scheduling': FieldValue.arrayUnion([scheduling!.toJson()])
      });
      await firestore
          .collection('users')
          .doc(doctorData.uid)
          .collection('notifications')
          .doc(id)
          .set({
        'id': id,
        'title': 'scheduled_appointment',
        'clicked': false,
        'timestamp': Timestamp.now().millisecondsSinceEpoch.toString(),
        'orderData': {
          'id': id,
          'dateTime': dateTimePicker.toString(),
          'timestamp': id,
          'note': note.text,
          'paymentMethod': paymentMethod,
          'doctorData': doctorData.toJson(),
          'userData': Get.find<AuthController>().userData!.toJson()
        }
      });
      Get.off(() => MessagesScreen(
            userData: doctorData,
            orderData: OrderModel.fromJson({
              'id': id,
              'dateTime': dateTimePicker.toString(),
              'timestamp': id,
              'note': note.text,
              'paymentMethod': paymentMethod,
              'doctorData': doctorData.toJson(),
              'userData': Get.find<AuthController>().userData!.toJson()
            }),
          ));
    }

    orderingLoading = false;
    paymentMethod = 'visa';
    done = false;
    update();
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
