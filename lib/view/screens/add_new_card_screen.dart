import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false, loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: 'add_new_card'.tr,
      // ),
      body: Column(
        children: [
          CreditCardWidget(
            cardBgColor: appConstant.primaryColor,
            enableFloatingCard: true,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          ),
          CreditCardForm(
            formKey: formKey,
            obscureCvv: true,
            obscureNumber: true,
            cardNumber: cardNumber,
            cvvCode: cvvCode,
            cardHolderName: cardHolderName,
            expiryDate: expiryDate,
            inputConfiguration: InputConfiguration(
              cardNumberDecoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: appConstant.primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'number'.tr,
              ),
              expiryDateDecoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: appConstant.primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'expired_date'.tr,
              ),
              cvvCodeDecoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: appConstant.primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'CVV',
              ),
              cardHolderDecoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: appConstant.primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'card_holder'.tr,
              ),
            ),
            onCreditCardModelChange: onCreditCardModelChange,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: CustomButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                Get.defaultDialog(
                    title: '',
                    radius: 24,
                    content: Column(
                      children: [
                        CircleAvatar(
                            radius: 60,
                            backgroundColor: appConstant.primaryColor,
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 75,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: Text(
                            'success'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        // CustomButton(
                        //     raduis: 10,
                        //     width: Get.width * 0.4,
                        //     function: () {
                        //       Get.back();
                        //       Get.back();
                        //     },
                        //     title: 'back'.tr),
                      ],
                    ));
              },
              title: 'add'.tr,
              width: Get.width * 0.75,
            ),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
