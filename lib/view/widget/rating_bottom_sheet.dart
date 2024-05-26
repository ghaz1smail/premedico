import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/order_model.dart';
import 'package:premedico/view/widget/custom_button.dart';

class RatingBottomSheet extends StatefulWidget {
  final OrderModel orderData;

  const RatingBottomSheet({super.key, required this.orderData});

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  double rate = 3;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'review_the_consultation'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: RatingBar(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  onRatingChanged: (value) {
                    rate = value;
                  },
                  initialRating: rate,
                  maxRating: 5,
                ),
              )),
          CustomButton(
              onPressed: () {
                firestore
                    .collection('orders')
                    .doc(widget.orderData.id)
                    .update({'rate': rate.toString()});
                Get.back();
                Get.back();
              },
              title: 'review')
        ],
      ),
    ));
  }
}
