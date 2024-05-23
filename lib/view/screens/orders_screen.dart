import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/order_model.dart';
import 'package:premedico/view/screens/chat_screen.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collection('orders')
          .where('userData.uid',
              isEqualTo: Get.find<AuthController>().userData!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = snapshot.data!.docs
              .map((e) => OrderModel.fromJson(e.data()))
              .toList();

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              var data = list[index];
              return ListTile(
                title: Text(data.id),
                onTap: () {
                  Get.to(() => ChatScreen(userData: data.doctorData));
                },
              );
            },
          );
        }
        return const CustomLoading();
      },
    );
  }
}
