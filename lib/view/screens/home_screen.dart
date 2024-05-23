import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/screens/all_top_favourite_screen.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/favourite_doctors_list.dart';
import 'package:premedico/view/widget/top_doctors_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: appConstant.primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(15))),
              child: SafeArea(
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CustomImage(
                        url: controller.userData!.image!,
                      ),
                      title: Text(
                        'welcome'.tr,
                        style: TextStyle(
                            fontSize: 14, color: appConstant.backgroundColor),
                      ),
                      subtitle: Text(
                        controller.userData!.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: appConstant.backgroundColor,
                            fontSize: 16),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          Get.toNamed('notifications');
                          // Get.to(() => const ChatsScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5,
                                  color: appConstant.backgroundColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Icon(
                            Icons.notifications,
                            color: appConstant.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoSearchTextField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Icon(
                          CupertinoIcons.search,
                          color: appConstant.backgroundColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      placeholder: 'search_doctors_hospitals'.tr,
                      placeholderStyle: const TextStyle(color: Colors.white60),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            color: appConstant.backgroundColor,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.update();
                },
                color: appConstant.secondaryColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      color: appConstant.backgroundColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed('callAmbulance');
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/ambulance.png',
                                            height: 50,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'call_ambulance'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed('hospitals');
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/hospital.png',
                                            height: 50,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'hospitals'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed('surgeryPackage');
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/package.png',
                                            height: 50,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'surgery_package'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'favourite_doctors'.tr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(() => const AllTopFavouriteScreen(
                                            top: false,
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
                          const FavouriteDoctorsList(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'top_doctors'.tr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(
                                          () => const AllTopFavouriteScreen());
                                    },
                                    child: Text(
                                      'see_all'.tr,
                                      style: TextStyle(
                                          color: appConstant.secondaryColor),
                                    ))
                              ],
                            ),
                          ),
                          const TopDoctorsList()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
