import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/dashboard_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/screens/doctors_list_screen.dart';
import 'package:premedico/view/widget/top_doctors_grid.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CupertinoSearchTextField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child:
                      Icon(CupertinoIcons.search, color: Colors.grey.shade500),
                ),
                padding: const EdgeInsets.all(10),
                placeholder: 'search_doctors_hospitals'.tr,
                placeholderStyle: TextStyle(color: Colors.grey.shade500),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: Get.width,
                      height: Get.height * .17,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: CarouselSlider.builder(
                              itemCount: controller.banner.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: CustomImage(
                                        radius: 0,
                                        url: controller.banner[itemIndex],
                                        width: Get.width,
                                        boxFit: BoxFit.fill,
                                      )),
                              options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  controller.changeBannerIndex(index);
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            child: SizedBox(
                              width: Get.width,
                              child: Align(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: controller.bannerIndex,
                                  count: controller.banner.length,
                                  effect: ScrollingDotsEffect(
                                      dotWidth: 6,
                                      dotHeight: 6,
                                      activeDotColor: appConstant.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('callAmbulance');
                          },
                          child: Chip(
                            label: Text(
                              'call_ambulance'.tr,
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
                            Get.toNamed('ordersScreen');
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'top_doctors'.tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => const DoctorsListScreen());
                              },
                              child: Text(
                                'see_all'.tr,
                                style: TextStyle(
                                    color: appConstant.secondaryColor),
                              ))
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 400,
                        width: Get.width,
                        child: const TopDoctorsGrid())
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
