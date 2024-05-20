import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color? color, textColor;
  final double? width, height;
  final bool loading, border;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.color,
      this.textColor,
      this.height,
      this.width,
      this.loading = false,
      this.border = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (!loading) {
          onPressed();
        }
      },
      elevation: 1,
      minWidth: width ?? Get.width,
      height: height ?? 50,
      color: color ?? appConstant.primaryColor,
      shape: RoundedRectangleBorder(
          side: border
              ? BorderSide(color: textColor ?? Colors.white)
              : BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: loading
          ? const CustomLoading(
              green: false,
              size: 50,
            )
          : Text(
              title.tr,
              style: TextStyle(
                  color: textColor ?? appConstant.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
    );
  }
}
