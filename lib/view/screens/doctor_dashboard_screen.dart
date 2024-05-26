import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/controller/dashboard_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/package_model.dart';
import 'package:premedico/view/screens/orders_screen.dart';
import 'package:premedico/view/screens/surgery_package_screen.dart';
import 'package:premedico/view/widget/custom_banner.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_drawer.dart';
import 'package:premedico/view/widget/custom_image.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'home_screen'.tr,
                style: const TextStyle(color: Colors.black),
              ),
              leading: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ));
              }),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.toNamed('notifications');
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ))
              ],
            ),
            drawer: const CustomDrawer(),
            backgroundColor: appConstant.backgroundColor,
            body: Column(
              children: [
                const CustomBanner(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('scheduling');
                      },
                      child: Chip(
                        label: Text(
                          'scheduling'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('ai');
                      },
                      child: Chip(
                        label: Text(
                          'AI_assistant'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const OrdersScreen(
                          user: false,
                        ));
                      },
                      child: Chip(
                        label: Text(
                          'private_conseltation'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: firestore
                      .collection('packages')
                      .where('doctorData.uid',
                          isEqualTo: Get.find<AuthController>().userData?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var list = snapshot.data!.docs
                          .map((e) => PackageModel.fromJson(e.data()));
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'sergery_package'.tr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                if (list.isNotEmpty)
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() => const SurgeryPackageScreen(
                                              user: false,
                                            ));
                                      },
                                      child: Text(
                                        'see_all'.tr,
                                        style: TextStyle(
                                            color: appConstant.secondaryColor),
                                      ))
                              ],
                            ),
                          ),
                          list.isEmpty
                              ? CustomButton(
                                  width: Get.width * 0.5,
                                  onPressed: () {
                                    Get.toNamed('newPackage');
                                  },
                                  title: 'add_new')
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  height: 125,
                                  width: Get.width,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var data = list.toList()[index];
                                      return Column(
                                        children: [
                                          CustomImage(
                                            url: data.image!,
                                            radius: 10,
                                            height: 100,
                                            width: 100,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(data.name!)
                                        ],
                                      );
                                    },
                                  ))
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ));
      },
    );
  }
}
