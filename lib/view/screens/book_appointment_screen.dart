import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/order_controller.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/widget/custom_image.dart';

class BookAppointmentScreen extends StatelessWidget {
  final UserModel doctorData;
  const BookAppointmentScreen({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'appointment'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))),
      body: GetBuilder<OrderController>(
        builder: (controller) {
          if (controller.randomTime.isEmpty) {
            controller.pickRandomTime();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 0.1,
                            color: Colors.black12)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomImage(
                          url: doctorData.image ?? '',
                          width: 100,
                          height: 100,
                          radius: 10,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorData.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                              '${doctorData.major} | ${doctorData.hospital == null ? '' : doctorData.hospital!.name}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 12),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(doctorData.rate.toString()),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
