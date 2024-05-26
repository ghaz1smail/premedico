import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_text_field.dart';

class AddNewPackage extends StatefulWidget {
  const AddNewPackage({super.key});

  @override
  State<AddNewPackage> createState() => _AddNewPackageState();
}

class _AddNewPackageState extends State<AddNewPackage> {
  bool loading = false;
  File? imageFile;
  TextEditingController name = TextEditingController(),
      price = TextEditingController(),
      pre = TextEditingController(),
      into = TextEditingController(),
      post = TextEditingController();
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 1);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {});

      await firebaseStorage.ref().child('packages/$id').putData(
          File(pickedFile.path).readAsBytesSync(),
          SettableMetadata(contentType: 'image/png'));
    }
  }

  addOne() async {
    var url = '';
    setState(() {
      loading = true;
    });
    if (imageFile != null) {
      url = await firebaseStorage.ref().child('packages/$id').getDownloadURL();
    }
    await firestore.collection('packages').doc(id).set({
      'id': id,
      'name': name.text,
      'price': price.text,
      'pre': pre.text,
      'post': post.text,
      'into': into.text,
      'image': url,
      'doctorData': Get.find<AuthController>().userData!.toJson()
    });

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_new'.tr,
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => pickImage(),
                child: Align(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imageFile != null
                        ? Image.file(
                            imageFile!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.photo,
                            size: 100,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: name,
                  hint: 'enter_package_name',
                  label: 'package_name'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: price,
                  hint: 'enter_package_price',
                  label: 'package_price'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: pre, hint: 'package_pre', label: 'package_pre'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: post,
                  hint: 'package_post',
                  label: 'package_post'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: into,
                  hint: 'package_into',
                  label: 'package_into'),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                width: Get.width * 0.5,
                onPressed: () async {
                  addOne();
                },
                title: 'submit',
                loading: loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
