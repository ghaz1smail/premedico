import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/package_model.dart';
import 'package:premedico/view/screens/surgery_details_screen.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class SurgeryPackageScreen extends StatelessWidget {
  final bool user;
  const SurgeryPackageScreen({super.key, this.user = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appConstant.primaryColor,
        appBar: AppBar(
          title: Text('sergery_package'.tr),
          backgroundColor: appConstant.primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('historyPackage');
                },
                icon: const Icon(Icons.history))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: appConstant.backgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: StreamBuilder(
              stream: user
                  ? firestore.collection('packages').snapshots()
                  : firestore
                      .collection('packages')
                      .where('doctorData.uid',
                          isEqualTo: Get.find<AuthController>().userData!.uid)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var list = snapshot.data!.docs
                      .map((e) => PackageModel.fromJson(e.data()))
                      .toList();
                  if (list.isEmpty) {
                    return Center(
                      child: Text('no_data'.tr),
                    );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var data = list[index];
                      return GestureDetector(
                        onTap: () {
                          if (user) {
                            Get.to(
                                () => SurgeryDetailsScreen(packageData: data));
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  CustomImage(
                                    url: data.image!,
                                    radius: 20,
                                    height: 125,
                                    width: 125,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      runSpacing: 10,
                                      children: [
                                        Text(
                                          '${'pre'.tr}: ${data.pre!}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '${'into'.tr}: ${data.into!}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '${'post'.tr}: ${data.post!}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Card(
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${'supervised_by'.tr} ${data.doctorData!.name}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.doctorData!.hospital!.name!,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          '${'jod'.tr} ${data.price}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }

                return const CustomLoading();
              },
            )));
  }
}
