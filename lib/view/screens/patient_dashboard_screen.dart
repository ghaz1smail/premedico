import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/dashboard_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/screens/chats_screen.dart';
import 'package:premedico/view/screens/doctors_list_screen.dart';
import 'package:premedico/view/screens/home_screen.dart';
import 'package:premedico/view/widget/custom_drawer.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (dashboardController) {
        return Scaffold(
          appBar: AppBar(
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
          bottomNavigationBar: SafeArea(
              child: Container(
            height: Get.width * 0.15,
            decoration: BoxDecoration(
                color: appConstant.backgroundColor,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, -5),
                      color: Colors.black12,
                      blurRadius: 7,
                      spreadRadius: 0.05),
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(dashboardController.bottomItems.length,
                    (index) {
                  var item = dashboardController.bottomItems[index];
                  return InkWell(
                    onTap: () {
                      dashboardController.changeIndex(index);
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                            color: dashboardController.selectedIndex == index
                                ? appConstant.primaryColor.withOpacity(0.07)
                                : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Icon(
                          item,
                          color: appConstant.primaryColor,
                          size: 30,
                        )),
                  );
                })),
          )),
          body: IndexedStack(
            index: dashboardController.selectedIndex,
            children: const [
              HomeScreen(),
              DoctorsListScreen(
                showBar: false,
              ),
              ChatsScreen()
            ],
          ),
        );
      },
    );
  }
}
