import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/dashboard_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Container(
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
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
        );
      },
    );
  }
}
