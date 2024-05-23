import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/order_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_text_field.dart';

class DescribeBottomSheet extends StatelessWidget {
  const DescribeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'describe'.tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'done'.tr,
                          style: TextStyle(color: appConstant.primaryColor),
                        ))
                  ],
                ),
              ),
              CustomTextField(
                hint: 'note',
                label: '',
                inputType: TextInputType.multiline,
                controller: controller.note,
              ),
            ],
          ),
        ));
      },
    );
  }
}
