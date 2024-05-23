import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/order_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_loading.dart';
import 'package:premedico/view/widget/describe_bottom_sheet.dart';

class BookAppointmentScreen extends StatelessWidget {
  final UserModel doctorData;
  const BookAppointmentScreen({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      if (controller.randomTime.isEmpty) {
        controller.pickRandomTime();
      }
      return Scaffold(
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: Get.width * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'total'.tr,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${'60'.tr} ${'jod'.tr}',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  controller.orderingLoading
                      ? const CustomLoading(
                          green: true,
                        )
                      : CustomButton(
                          width: Get.width * 0.4,
                          height: 55,
                          onPressed: () {
                            controller.createOrder(doctorData);
                          },
                          title: 'book'),
                ],
              ),
            ),
          ),
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
          body: Padding(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'date'.tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'change'.tr,
                          style: TextStyle(color: appConstant.primaryColor),
                        ))
                  ],
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.2),
                    child: Icon(Icons.calendar_month,
                        color: appConstant.primaryColor),
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: Text(DateFormat('EEEE, MM dd,yyyy | hh:mm a')
                      .format(controller.dateTimePicker)),
                ),
                Divider(
                  height: 30,
                  thickness: 0.2,
                  color: appConstant.primaryColor,
                ),
                Text(
                  'reason'.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                ListTile(
                  onTap: () {
                    customBottomSheet(const DescribeBottomSheet());
                  },
                  subtitle: controller.note.text.isNotEmpty
                      ? Text(
                          controller.note.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: appConstant.primaryColor.withOpacity(0.2),
                    child:
                        Icon(Icons.edit_note, color: appConstant.primaryColor),
                  ),
                  title: Text('describe_what_you_feel'.tr),
                ),
                Divider(
                  height: 30,
                  thickness: 0.2,
                  color: appConstant.primaryColor,
                ),
                Text(
                  'payment_detail'.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'consultation'.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${doctorData.price ?? 0} ${'jod'.tr}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'admin_fee'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${controller.adminFee} ${'jod'.tr}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'total'.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${(doctorData.price ?? 0) + controller.adminFee} ${'jod'.tr}',
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                  thickness: 0.2,
                  color: appConstant.primaryColor,
                ),
                Text(
                  'payment_method'.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: appConstant.primaryColor, width: 0.1)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.credit_card,
                        color: Color.fromARGB(255, 6, 49, 85),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'visa'.tr,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 6, 49, 85),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Radio(
                          activeColor: appConstant.primaryColor,
                          value: 'visa',
                          groupValue: controller.paymentMethod,
                          onChanged: (x) {
                            controller.changePayment('visa');
                          })
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: appConstant.primaryColor, width: 0.1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.payments,
                          color: Color.fromARGB(255, 25, 97, 27)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'cash'.tr,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 25, 97, 27),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Radio(
                          activeColor: appConstant.primaryColor,
                          value: 'cash',
                          groupValue: controller.paymentMethod,
                          onChanged: (x) {
                            controller.changePayment('cash');
                          })
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
