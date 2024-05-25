import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/order_model.dart';
import 'package:premedico/view/screens/doctors_list_screen.dart';
import 'package:premedico/view/screens/messages_screen.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class OrdersScreen extends StatefulWidget {
  final bool showBar;
  const OrdersScreen({super.key, this.showBar = true});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showBar
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const DoctorsListScreen());
        },
        backgroundColor: appConstant.primaryColor,
        child: const Icon(Icons.add),
      ),
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

            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var data = list[index];
                  return orderWidget(data);
                },
              ),
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }

  String printLastThreeChars(String input) {
    if (input.length >= 3) {
      String lastThreeChars = input.substring(input.length - 3);
      return lastThreeChars;
    } else {
      return input;
    }
  }

  Widget orderWidget(OrderModel data) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: CustomImage(
            url: data.doctorData.image ?? '',
            radius: 10,
          ),
          trailing: Text('#${printLastThreeChars(data.id)}'),
          subtitle: Text(DateFormat('dd/mm/yyyy, hh:mm')
              .format(DateTime.parse(data.dateTime))),
          title: Text(data.doctorData.name ?? ''),
          onTap: () {
            Get.to(() => MessagesScreen(userData: data.doctorData));
          },
        ),
      ),
    );
  }
}
