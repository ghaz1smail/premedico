import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return ListView(
          children: [
            Container(
              decoration: const BoxDecoration(),
              child: const Column(
                children: [],
              ),
            )
          ],
        );
      },
    );
  }
}
