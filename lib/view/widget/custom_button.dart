import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color? color;
  final double? width, height;
  final bool loading;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.color,
      this.height,
      this.width,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (!loading) {
          onPressed();
        }
      },
      minWidth: width ?? Get.width,
      height: height ?? 50,
      color: color ?? appConstant.primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: loading
          ? const CustomLoading(
              green: false,
              size: 50,
            )
          : Text(
              title.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
    );
  }
}
