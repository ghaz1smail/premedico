import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/hospital_model.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_shimmer.dart';
import 'package:premedico/view/widget/doctor_widget.dart';

class HospitalDetailsScreen extends StatelessWidget {
  final HospitalModel hospitalData;
  const HospitalDetailsScreen({super.key, required this.hospitalData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CustomImage(url: hospitalData.image!),
            title: Text(hospitalData.name!),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'top_doctors'.tr,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          StreamBuilder(
              stream: firestore
                  .collection('users')
                  .where('hospital.id', isEqualTo: hospitalData.id)
                  .snapshots(),
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
                      return DoctorWidget(
                        doctorData: userData,
                      );
                    },
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CustomShimmer(
                        child: DoctorWidget(doctorData: UserModel()));
                  },
                );
              }),
        ],
      ),
    );
  }
}
