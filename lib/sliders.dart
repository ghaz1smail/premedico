
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_application_1/login.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_application_1/main.dart';
//import 'package:flutter_application_1/signup.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xff007F70);

  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: kDarkBlueColor,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      ),
      // skipTextButton: Text(
      //   'Skip',
      //   style: TextStyle(
      //     fontSize: 16,
      //     color: kDarkBlueColor,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      // trailing: Text(
      //   'Login',
      //   style: TextStyle(
      //     fontSize: 16,
      //     color: kDarkBlueColor,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      trailingFunction: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const MyHome(),
          ),
        );
      },
      controllerColor: kDarkBlueColor,
      totalPage: 4,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Image.asset(
          'images/p1.jpg',
          height: 400,
        ),
        Image.asset(
          'images/p2.jpg',
          height: 400,

        ),
        Image.asset(
          'images/p3.jpg',
          height: 400,

        ), Image.asset(
          'images/p4.jpg',
          height: 400,

        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               const SizedBox(
                 height: 480,
               ),
              // Text(
              //   'Hello',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: kDarkBlueColor,
              //     fontSize: 24.0,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Consult only with a doctor you trust',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              // Text(
              //   'Welcome',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: kDarkBlueColor,
              //     fontSize: 24.0,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Find a ot of specialist doctor in one place',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Thank you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkBlueColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Get connect with our online consultation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Start now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkBlueColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Where everyone is here to help you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}