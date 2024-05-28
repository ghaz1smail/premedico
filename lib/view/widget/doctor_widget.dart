import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/doctor_details_screen.dart';
import 'package:premedico/view/widget/custom_image.dart';

class DoctorWidget extends StatefulWidget {
  final UserModel doctorData;
  const DoctorWidget({super.key, required this.doctorData});

  @override
  State<DoctorWidget> createState() => _DoctorWidgetState();
}

class _DoctorWidgetState extends State<DoctorWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DoctorDetailsScreen(doctorData: widget.doctorData));
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
                url: widget.doctorData.image ?? '',
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
                            widget.doctorData.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        if (widget.doctorData.favorites != null)
                          InkWell(
                            onTap: () async {
                              await firestore
                                  .collection('users')
                                  .doc(widget.doctorData.uid)
                                  .update({
                                'favorites': widget.doctorData.favorites!
                                        .contains(Get.find<AuthController>()
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
                              widget.doctorData.favorites!.contains(
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
                    '${widget.doctorData.major} | ${widget.doctorData.hospital == null ? '' : widget.doctorData.hospital!.name}',
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
                      Text(widget.doctorData.rate.toString()),
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
