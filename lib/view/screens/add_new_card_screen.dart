import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/order_controller.dart';
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
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
            'add_new_card'.tr,
            style: const TextStyle(color: Colors.black),
          )),
      body: ListView(
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
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: CustomButton(
              loading: loading,
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                setState(() {
                  loading = true;
                });
                Get.find<OrderController>().done = true;
                await Future.delayed(const Duration(seconds: 2));
                Get.back();
              },
              title: 'pay',
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
