import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/order_model.dart';

class FunctionsController extends GetxController {
  checkAppointments() async {
    firestore
        .collection('orders')
        .where('dateTime',
            isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
        .get()
        .then((x) {
      var list = x.docs.map((e) => OrderModel.fromJson(e.data())).toList();
      for (var e in list) {
        if (DateTime.parse(e.dateTime).difference(DateTime.now()).inDays == 1) {
          firestore
              .collection('users')
              .doc(e.userData.uid)
              .collection('notifications')
              .doc(e.id)
              .get()
              .then((e2) {
            if (!e2.exists) {
              firestore
                  .collection('users')
                  .doc(e.userData.uid)
                  .collection('notifications')
                  .doc(e.id)
                  .set({
                'id': e.id,
                'title': 'reminder_tommorow',
                'clicked': false,
                'timestamp': Timestamp.now().millisecondsSinceEpoch.toString(),
                'orderData': e.toJson()
              });
            }
          });
        }
      }
    });
  }
}
