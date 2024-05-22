import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/view/widget/top_doctors_list.dart';

class AllTopFavouriteScreen extends StatelessWidget {
  final bool top;
  const AllTopFavouriteScreen({super.key, this.top = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            top ? 'top_doctors'.tr : 'favourite_doctors'.tr,
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
      body: TopDoctorsList(
        top: top,
      ),
    );
  }
}
