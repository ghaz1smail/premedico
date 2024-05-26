import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';

class AddSchedulingScreen extends StatefulWidget {
  const AddSchedulingScreen({super.key});

  @override
  State<AddSchedulingScreen> createState() => _AddSchedulingScreenState();
}

class _AddSchedulingScreenState extends State<AddSchedulingScreen> {
  DateTime dateTimePicker = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool loading = false;

  changeDate(DateTime newDateTimePicker) {
    dateTimePicker = DateTime(
      newDateTimePicker.year,
      newDateTimePicker.month,
      newDateTimePicker.day,
      dateTimePicker.hour,
      dateTimePicker.minute,
    );
    setState(() {});
  }

  changeTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != selectedTime) {
      dateTimePicker = DateTime(
        dateTimePicker.year,
        dateTimePicker.month,
        dateTimePicker.day,
        picked!.hour,
        picked.minute,
      );
      selectedTime = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_new'.tr,
          style: TextStyle(
              color: appConstant.primaryColor, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'pick_date'.tr,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 75,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    final dateTime = DateTime.now().add(Duration(days: index));
                    return GestureDetector(
                      onTap: () {
                        changeDate(dateTime);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: Get.width * 0.12,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: dateTimePicker.day == dateTime.day &&
                                    dateTimePicker.month == dateTime.month
                                ? appConstant.primaryColor
                                : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color:
                                    appConstant.primaryColor.withOpacity(0.2))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EE').format(dateTime),
                              style: TextStyle(
                                color: dateTimePicker.day == dateTime.day &&
                                        dateTimePicker.month == dateTime.month
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
                                  color: dateTimePicker.day == dateTime.day &&
                                          dateTimePicker.month == dateTime.month
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
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: CustomButton(
                    onPressed: () {
                      changeTime();
                    },
                    title: 'pick_time  ${selectedTime.format(context)}'),
              ),
              const Spacer(),
              CustomButton(
                width: Get.width * 0.5,
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await firestore
                      .collection('users')
                      .doc(Get.find<AuthController>().userData!.uid)
                      .update({
                    'scheduling': FieldValue.arrayUnion([
                      {'date': dateTimePicker.toString(), 'user': ''}
                    ])
                  });
                  Get.back();
                },
                title: 'submit',
                loading: loading,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
