import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/order_model.dart';
import 'package:premedico/view/screens/messages_screen.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class OrdersScreen extends StatelessWidget {
  final bool showBar;
  const OrdersScreen({super.key, this.showBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBar
          ? AppBar(
              title: Text(
                'private_conseltation'.tr,
                style: TextStyle(
                    color: appConstant.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )))
          : null,
      body: StreamBuilder(
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
                    Get.to(() => MessagesScreen(userData: data.doctorData));
                  },
                );
              },
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }
}
