import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/doctor_details_screen.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_shimmer.dart';

class DoctorsListScreen extends StatefulWidget {
  final bool showBar;
  const DoctorsListScreen({super.key, this.showBar = true});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showBar
          ? AppBar(
              title: Text(
                'top_doctors'.tr,
                style: TextStyle(
                    color: appConstant.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )))
          : null,
      body: StreamBuilder(
          stream: widget.showBar
              ? firestore
                  .collection('users')
                  .where('type', isEqualTo: 'doctor')
                  .snapshots()
              : firestore.collection('users').where('favorites',
                  arrayContainsAny: [
                      Get.find<AuthController>().userData!.uid
                    ]).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserModel> doctors = snapshot.data!.docs
                  .map((e) => UserModel.fromJson(e.data()))
                  .toList();
              if (doctors.isEmpty) {
                return Center(
                  child: Text(
                    'no_data'.tr,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  var userData = doctors[index];
                  return topDoctorWidget(userData);
                },
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomShimmer(child: topDoctorWidget(UserModel()));
              },
            );
          }),
    );
  }

  Widget topDoctorWidget(UserModel userData) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DoctorDetailsScreen(doctorData: userData));
      },
      child: Container(
        width: Get.width,
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(blurRadius: 5, spreadRadius: 0.5, color: Colors.black12)
            ],
            color: appConstant.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomImage(
                url: userData.image ?? '',
                width: 75,
                height: 75,
                radius: 10,
              ),
            ),
            IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: Get.width - 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            userData.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        if (userData.favorites != null)
                          InkWell(
                            onTap: () async {
                              await firestore
                                  .collection('users')
                                  .doc(userData.uid)
                                  .update({
                                'favorites': userData.favorites!.contains(
                                        Get.find<AuthController>()
                                            .userData!
                                            .uid)
                                    ? FieldValue.arrayRemove([
                                        Get.find<AuthController>().userData!.uid
                                      ])
                                    : FieldValue.arrayUnion([
                                        Get.find<AuthController>().userData!.uid
                                      ])
                              });
                              setState(() {});
                            },
                            child: Icon(
                              userData.favorites!.contains(
                                      Get.find<AuthController>().userData!.uid)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: appConstant.primaryColor,
                              size: 17,
                            ),
                          )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Divider(),
                  ),
                  Text(
                    '${userData.major} | ${userData.hospital == null ? '' : userData.hospital!.name}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(userData.rate.toString()),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
