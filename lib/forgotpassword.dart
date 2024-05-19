// ignore_for_file: unused_import, unused_field, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
//import 'package:flutter_application_1/signup.dart';
//import 'package:flutter_application_1/login.dart';
//import 'dart:developer';
//import 'dart:ui';
 
 
 
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
 
//   runApp(const MyApp());
// }
 
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
      home: const Password(title: 'Flutter Demo Home Page'),
      scaffoldMessengerKey: _messengerKey,
      
    );
  }
}
 
class Password extends StatefulWidget {
  const Password({super.key, required this.title});
 
  final String title;
 
  @override
  State<Password> createState() => _PasswordState();
}
 
class _PasswordState extends State<Password> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // int _success = 1;
  //String _userEmail = "";
  final _key = GlobalKey<FormState>();
  bool? _checkboxvalue = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: const Text(
                    "Forgot your password ? ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
                  height: 10,
                ),
             Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "     Please enter your email or your phone number",
                      style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                 
                  ),
                  textAlign: TextAlign.center,
                ),
                 
                SizedBox(height: 20),
                  ],
                ),
            Container(
              padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.number,
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
                 
                  const SizedBox(
                    height: 5.0,
                  ),
               
                  const SizedBox(
                    height: 60,
                  ),
 
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(9, 123, 100, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Resend Password ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
 
                  InkWell(
                    onTap: () {Navigator.of(context).pushNamed("login");},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)
                     
                      ),
                      child: Center(
                        
                          child: Text(
                        "Back to Login ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
 
                 
                  const SizedBox(
                    height: 110,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(
                          'Dont have an Acccount ? ',
                          style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize:12, color: Colors.black38)
                        ),
                        InkWell(
                          onTap: () {
                              Navigator.of(context).pushNamed("signup");
                            },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color:Color.fromRGBO(9, 123, 100, 1),
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
    );
  }
 
 
 
  String? _emailValidation(String? value) {
    if (value!.isEmpty) {
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
  }
 
  void _login() {
    if (_key.currentState!.validate()) {
      _messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text('Welcome: ${emailController.text}')));
         
    }
  }
}