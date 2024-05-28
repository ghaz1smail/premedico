import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'scheduling'.tr,
          style: TextStyle(
              color: appConstant.primaryColor, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                await Get.toNamed('newScheduling');
                setState(() {});
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: firestore
            .collection('users')
            .doc(Get.find<AuthController>().userData!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = UserModel.fromJson(snapshot.data!.data() as Map);
            if (data.scheduling!.isEmpty) {
              return Center(
                child: Text('no_data'.tr),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: data.scheduling!.length,
              itemBuilder: (context, index) {
                var d = data.scheduling![index];
                return Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(d.date!),
                        ),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(DateTime.parse(d.date!)),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }
}
