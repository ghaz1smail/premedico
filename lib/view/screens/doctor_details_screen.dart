import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/controller/order_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/book_appointment_screen.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:readmore/readmore.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final UserModel doctorData;
  const DoctorDetailsScreen({super.key, required this.doctorData});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  void dispose() {
    Get.find<OrderController>().randomTime.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SafeArea(
          child: SizedBox(
            height: Get.width * 0.15,
            child: Align(
              child: CustomButton(
                  width: Get.width * 0.75,
                  height: 55,
                  onPressed: () {
                    if (Get.find<OrderController>().scheduling != null) {
                      Get.to(() => BookAppointmentScreen(
                            doctorData: widget.doctorData,
                          ));
                    } else {
                      Get.snackbar(
                        'sorry'.tr,
                        'Please select a time slot',
                      );
                    }
                  },
                  title: 'book_private_consultation'),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          actions: [
            StreamBuilder(
              stream: firestore
                  .collection('users')
                  .doc(widget.doctorData.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (!snapshot.data!.exists) {
                    return const SizedBox();
                  }
                  var data = UserModel.fromJson(snapshot.data!.data() as Map);
                  return IconButton(
                      onPressed: () async {
                        await firestore
                            .collection('users')
                            .doc(widget.doctorData.uid)
                            .update({
                          'favorites': data.favorites!.contains(
                                  Get.find<AuthController>().userData!.uid)
                              ? FieldValue.arrayRemove(
                                  [Get.find<AuthController>().userData!.uid])
                              : FieldValue.arrayUnion(
                                  [Get.find<AuthController>().userData!.uid])
                        });
                        setState(() {});
                      },
                      icon: Icon(
                        data.favorites!.contains(
                                Get.find<AuthController>().userData!.uid)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: appConstant.primaryColor,
                      ));
                }
                return IconButton(
                    onPressed: () async {},
                    icon: Icon(
                      widget.doctorData.favorites!.contains(
                              Get.find<AuthController>().userData!.uid)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: appConstant.primaryColor,
                    ));
              },
            )
          ],
          title: Text(
            'doctor_details'.tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<OrderController>(
          builder: (controller) {
            if (controller.randomTime.isEmpty) {
              controller.pickRandomTime();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomImage(
                            url: widget.doctorData.image ?? '',
                            width: 100,
                            height: 100,
                            radius: 10,
                            boxFit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctorData.name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 10),
                                child: Text(
                                  '${widget.doctorData.major} | ${widget.doctorData.hospital == null ? '' : widget.doctorData.hospital!.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 12),
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
                                  Text(widget.doctorData.rate.toString()),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.doctorData.bio!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 10),
                      child: Text(
                        'about'.tr,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (widget.doctorData.bio!.isNotEmpty)
                    ReadMoreText(
                      widget.doctorData.bio!,
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      lessStyle: TextStyle(
                          color: appConstant.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      moreStyle: TextStyle(
                          color: appConstant.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 75,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        final dateTime =
                            DateTime.now().add(Duration(days: index));
                        return GestureDetector(
                          onTap: () {
                            controller.changeDate(dateTime);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: Get.width * 0.12,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: controller.dateTimePicker.day ==
                                            dateTime.day &&
                                        controller.dateTimePicker.month ==
                                            dateTime.month
                                    ? appConstant.primaryColor
                                    : null,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    color: appConstant.primaryColor
                                        .withOpacity(0.2))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('EE').format(dateTime),
                                  style: TextStyle(
                                    color: controller.dateTimePicker.day ==
                                                dateTime.day &&
                                            controller.dateTimePicker.month ==
                                                dateTime.month
                                        ? Colors.white
                                        : appConstant.secondaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  dateTime.day.toString(),
                                  style: TextStyle(
                                      color: controller.dateTimePicker.day ==
                                                  dateTime.day &&
                                              controller.dateTimePicker.month ==
                                                  dateTime.month
                                          ? Colors.white
                                          : null,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 50,
                    color: appConstant.primaryColor,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, bottom: 25),
                    child: widget.doctorData.scheduling!
                            .where((e) =>
                                DateTime.parse(e.date!).day ==
                                    controller.dateTimePicker.day &&
                                DateTime.parse(e.date!).month ==
                                    controller.dateTimePicker.month)
                            .isEmpty
                        ? Center(
                            child: Text('no_data'.tr),
                          )
                        : Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: List.generate(
                                widget.doctorData.scheduling!
                                    .where((e) =>
                                        DateTime.parse(e.date!).day ==
                                            controller.dateTimePicker.day &&
                                        DateTime.parse(e.date!).month ==
                                            controller.dateTimePicker.month)
                                    .length, (index) {
                              final dateTime = widget.doctorData.scheduling!
                                  .where((e) =>
                                      DateTime.parse(e.date!).day ==
                                          controller.dateTimePicker.day &&
                                      DateTime.parse(e.date!).month ==
                                          controller.dateTimePicker.month)
                                  .toList()[index];

                              return Opacity(
                                opacity: dateTime.user!.isEmpty &&
                                        DateTime.parse(dateTime.date!)
                                            .isAfter(DateTime.now())
                                    ? 1
                                    : 0.25,
                                child: GestureDetector(
                                    onTap: () {
                                      if (dateTime.user!.isEmpty) {
                                        controller.changeTime(
                                            DateTime.parse(dateTime.date!));
                                        controller.scheduling = dateTime;
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: Get.width * 0.25,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          color: controller.dateTimePicker.hour ==
                                                      DateTime.parse(
                                                              dateTime.date!)
                                                          .hour &&
                                                  controller.dateTimePicker
                                                          .minute ==
                                                      DateTime.parse(
                                                              dateTime.date!)
                                                          .minute
                                              ? appConstant.primaryColor
                                              : null,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          border: Border.all(
                                              color: appConstant.primaryColor)),
                                      child: Text(
                                        DateFormat('h:mm a').format(
                                            DateTime.parse(dateTime.date!)),
                                        style: TextStyle(
                                            color: controller.dateTimePicker
                                                            .hour ==
                                                        DateTime.parse(
                                                                dateTime.date!)
                                                            .hour &&
                                                    controller.dateTimePicker
                                                            .minute ==
                                                        DateTime.parse(
                                                                dateTime.date!)
                                                            .minute
                                                ? Colors.white
                                                : null,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              );
                            })),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
