import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/package_model.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_image.dart';

class SurgeryDetailsScreen extends StatefulWidget {
  final PackageModel packageData;
  const SurgeryDetailsScreen({super.key, required this.packageData});

  @override
  State<SurgeryDetailsScreen> createState() => _SurgeryDetailsScreenState();
}

class _SurgeryDetailsScreenState extends State<SurgeryDetailsScreen> {
  bool loading = false;
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.packageData.name!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  CustomImage(
                    url: widget.packageData.image!,
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
                          '${'pre'.tr}: ${widget.packageData.pre!}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${'into'.tr}: ${widget.packageData.into!}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${'post'.tr}: ${widget.packageData.post!}',
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
                      '${'supervised_by'.tr} ${widget.packageData.doctorData!.name}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.packageData.doctorData!.hospital!.name!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${'jod'.tr} ${widget.packageData.price}',
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
            ),
            const Spacer(),
            CustomButton(
                width: Get.width * 0.5,
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await firestore.collection('book_packages').add({
                    'package': widget.packageData.toJson(),
                    'userData': Get.find<AuthController>().userData!.toJson(),
                    'timestamp': DateTime.now().toIso8601String()
                  });
                  Get.back();
                },
                loading: loading,
                title: 'book'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
