import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_image.dart';

class SurgeryPackageScreen extends StatelessWidget {
  const SurgeryPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appConstant.primaryColor,
        appBar: AppBar(
          title: Text('sergery_pakage'.tr),
          backgroundColor: appConstant.primaryColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: appConstant.backgroundColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20))),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tonsillectomy ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        CustomImage(
                          url:
                              'https://healthinfo.healthengine.com.au/assets/iStock-496401605.jpg',
                          radius: 20,
                          height: 125,
                          width: 125,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Wrap(
                            runSpacing: 10,
                            children: [
                              Text(
                                'Pre : Dr follow up , with lab tests',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Into: The whole surgery Anastasia',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Post :Dr follow up on medicine',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.grey.shade200,
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supervised by Dr.Amjad',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Luzmila Hospital',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'JOD 2000',
                                style: TextStyle(
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
          ),
        ));
  }
}
