// ignore_for_file: unused_import, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
//import 'dart:developer';
import 'dart:ui';
import 'package:flutter_application_1/forgotpassword.dart';
//final Firebase _auth = FirebaseAuth.instance;
//final FirebaseAuth _auth = FirebaseAuth.instance;

void main(List<String> args) {
  runApp(MyApp());
}
final _messengerKey = GlobalKey<ScaffoldMessengerState>();
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      scaffoldMessengerKey: _messengerKey,
       routes: {"forgetpassword":(context) => Password(title: "password")},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
 
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // int _success = 1;
  //String _userEmail = "";
  final _key = GlobalKey<FormState>();
  bool? _checkboxvalue = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Stack(
               // children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 40, 0, 0),
                    child: const Text(
                      "You must sign in to join ",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                //],
             // ),
              Container(
                padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _emailValidation,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.mail_sharp,
                          size: 18,
                        ),
                        hintText: "Enter Your Email",
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: Color.fromARGB(255, 145, 138, 138),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            size: 18,
                          ),
                          hintText: "Enter Your PassWord",
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Color.fromARGB(255, 145, 138, 138),
                          ),
                          labelText: 'PassWord',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color.fromARGB(255, 5, 0, 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ))),
                      obscureText: true,
                      validator: _validatePass,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: const Alignment(1, 0),
                      padding: const EdgeInsets.only(top: 17, left: 20),
                      child: Row(
                        children: [
                          const Text(
                            'Remember me ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Checkbox(
                              value: _checkboxvalue,
                              onChanged: (newValue) => oncheckboxchang(newValue)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
       
                    InkWell(
                      onTap: _login,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff007F70),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                            child: Text(
                          "Log In ",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                        )),
                      ),
                    ),
       
                    // ElevatedButton(
                    // onPressed: _login,
                    // child: const Text("Login"),
                    // ),
                    // Container(
                    //   height: 40,
                    //    child: Material(
                    //    borderRadius: BorderRadius.circular(20),
                    //  color: Color.fromARGB(255, 111, 146, 175),
                    //       elevation: 7,
                    //     child: GestureDetector(
                    //     onTap: () {
                    //     print('Log in ');
                    // },
                    // child: const Center(
                    //  child: Text(
                    //  'Log in ',
                    //     style: TextStyle(
                    //     color: Color.fromARGB(255, 6, 6, 6),
                    //   fontWeight: FontWeight.bold,
                    //            ),
                    //        )),
                    //    ),
                    //          ),
                    //      ),
                    // const SizedBox(
                    //   height: 6.0,
                    // ),
                    // Container(
                    //   alignment: const Alignment(1, 0),
                    //   padding: const EdgeInsets.only(top: 15, left: 20),
                    //   child: const InkWell(
                    //     child: Text(
                    //       'Forgot PassWord ? ',
                    //       style: TextStyle(
                    //         color: Color(0xff1f4172),
                    //         fontFamily: 'Montserrat',
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    // Container(
                    //            alignment: Alignment.center,
                    //          child: const Text(
                    //          '________Or sign in with________',
                    //        style: TextStyle(
                    //        color: Color.fromARGB(255, 144, 139, 139),
                    //      fontWeight: FontWeight.bold,
                    //  ),
                    //     ),
                    // ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Text(
                            'Dont have an Acccount ? ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("signup");
                            },
                            child:const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(9, 123, 100, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
 
  //String? _validUserName(String? value) {
  // if (value!.isEmpty) {
  // return "  Must not be empty";
  //   } else {
  //   return null;
  //   }
  // }
 
  String? _emailValidation(String? value) {
    if (emailController.text.isEmpty) {
      return "email should not be empty!!";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      return "must be email format!";
    }
  }
 
  oncheckboxchang(bool? newValue) {
    setState(() {
      _checkboxvalue = newValue;
    });
  }
 
  String? _validatePass(String? value) {
    if (value!.length <= 8 || value.isEmpty) {
      return 'Password must not be empty and greater than 8 charaters';
    }
    return null;
  }
 
  void _login() {
    if(_key.currentState!.validate()){
      print("successijhsiodfh");
    }
    
  }
}