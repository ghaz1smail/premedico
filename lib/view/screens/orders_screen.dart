import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/order_model.dart';
import 'package:premedico/view/screens/doctors_list_screen.dart';
import 'package:premedico/view/screens/messages_screen.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class OrdersScreen extends StatefulWidget {
  final bool showBar, user;

  const OrdersScreen({super.key, this.showBar = true, this.user = true});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  DateTime selectedDate = DateTime.now();

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
      floatingActionButton:
          Get.find<AuthController>().userData!.type != 'doctor'
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(() => const DoctorsListScreen());
                  },
                  backgroundColor: appConstant.primaryColor,
                  child: const Icon(Icons.add),
                )
              : null,
      body: StreamBuilder(
        stream: widget.user
            ? firestore
                .collection('orders')
                .where('userData.uid',
                    isEqualTo: Get.find<AuthController>().userData!.uid)
                // .orderBy('timestamp', descending: true)
                .snapshots()
            : firestore
                .collection('orders')
                .where('doctorData.uid',
                    isEqualTo: Get.find<AuthController>().userData!.uid)
                // .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data!.docs
                .map((e) => OrderModel.fromJson(e.data()))
                .toList();
            if (list.isEmpty) {
              return Center(child: Text('no_data'.tr));
            }
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

  selectDate(data) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day,
            selectedDate.hour, selectedDate.minute);
      });
      selectTime(data);
    }
  }

  selectTime(OrderModel data) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, picked.hour, picked.minute);
      });
      Get.defaultDialog(
          title: 'Are you sure you want to change the appointment?',
          content: Text(DateFormat('dd/MM/yyyy hh:mm a').format(selectedDate)),
          actions: [
            CustomButton(
                onPressed: () async {
                  Get.back();
                  await firestore
                      .collection('orders')
                      .doc(data.id)
                      .update({'dateTime': selectedDate.toIso8601String()});
                  await firestore
                      .collection('users')
                      .doc(data.userData.uid)
                      .collection('notifications')
                      .doc(data.id)
                      .set({
                    'id': data.id,
                    'title': 'change_appointment',
                    'clicked': false,
                    'timestamp':
                        Timestamp.now().millisecondsSinceEpoch.toString(),
                    'orderData': data.toJson()
                  });
                },
                title: 'submit')
          ]);
    }
  }

  Widget orderWidget(OrderModel data) {
    return GestureDetector(
      onLongPress: () {
        if (Get.find<AuthController>().userData!.type == 'doctor') {
          selectDate(data);
        }
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CustomImage(
              url: widget.user
                  ? data.doctorData.image.toString()
                  : data.userData.image.toString(),
              radius: 10,
            ),
            trailing: Text('#${printLastThreeChars(data.id)}'),
            subtitle: Text(DateFormat('dd/MM/yyyy, hh:mm')
                .format(DateTime.parse(data.dateTime))),
            title: Text(widget.user
                ? data.doctorData.name.toString()
                : data.userData.name.toString()),
            onTap: () {
              Get.to(() => MessagesScreen(
                    userData: widget.user ? data.doctorData : data.userData,
                    orderData: data,
                  ));
            },
          ),
        ),
      ),
    );
  }
}
