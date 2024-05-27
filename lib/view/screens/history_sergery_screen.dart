import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/package_model.dart';
import 'package:premedico/view/widget/custom_image.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class HistorySurgeryScreen extends StatelessWidget {
  const HistorySurgeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appConstant.primaryColor,
        appBar: AppBar(
          title: Text('my_packages'.tr),
          backgroundColor: appConstant.primaryColor,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: appConstant.backgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: StreamBuilder(
              stream: firestore
                  .collection('book_packages')
                  .where('userData.uid',
                      isEqualTo: Get.find<AuthController>().userData!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var list = snapshot.data!.docs
                      .map((e) => HistoryPackageModel.fromJson(e.data()))
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.packageData!.name!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                CustomImage(
                                  url: data.packageData!.image!,
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
                                        '${'pre'.tr}: ${data.packageData!.pre!}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${'into'.tr}: ${data.packageData!.into!}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${'post'.tr}: ${data.packageData!.post!}',
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
                                    '${'supervised_by'.tr} ${data.packageData!.doctorData!.name}',
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
                                        data.packageData!.doctorData!.hospital!
                                            .name!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        '${'jod'.tr} ${data.packageData!.price}',
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
                      );
                    },
                  );
                }

                return const CustomLoading();
              },
            )));
  }
}
