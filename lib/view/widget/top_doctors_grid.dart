import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/doctor_details_screen.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_shimmer.dart';

class TopDoctorsGrid extends StatefulWidget {
  const TopDoctorsGrid({super.key});

  @override
  State<TopDoctorsGrid> createState() => _TopDoctorsGridState();
}

class _TopDoctorsGridState extends State<TopDoctorsGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collection('users')
          .where('type', isEqualTo: 'doctor')
          .limit(4)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UserModel> doctors = snapshot.data!.docs
              .map((e) => UserModel.fromJson(e.data()))
              .toList();
          return Center(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 25),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: doctors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var userData = doctors[index];
                return favouriteDoctorWidget(userData);
              },
            ),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.1,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 25),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CustomShimmer(child: favouriteDoctorWidget(UserModel()));
          },
        );
      },
    );
  }

  Widget favouriteDoctorWidget(UserModel userData) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DoctorDetailsScreen(doctorData: userData));
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(blurRadius: 5, spreadRadius: 0.5, color: Colors.black12)
            ],
            color: appConstant.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.5,
              height: 110,
              child: Stack(
                children: [
                  CustomImage(
                    url: userData.image ?? '',
                    width: Get.width * 0.5,
                    radius: 10,
                  ),
                  if (userData.favorites != null)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: CircleAvatar(
                        backgroundColor: appConstant.backgroundColor,
                        radius: 15,
                        child: IconButton(
                            onPressed: () async {
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
                            icon: Icon(
                              userData.favorites!.contains(
                                      Get.find<AuthController>().userData!.uid)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: appConstant.primaryColor,
                              size: 15,
                            )),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                userData.name.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${userData.major} | ${userData.hospital == null ? '' : userData.hospital!.name}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
