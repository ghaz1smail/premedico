// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      scaffoldMessengerKey: _messengerKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool styleIOS = true;

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final _key = GlobalKey<FormState>();
  /*late String accounTypeValue;*/
  String? accounTypeValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: (styleIOS
                ? const Text("Nutrition Application")
                : const Text(""))),
        body: Container(
          padding: const EdgeInsets.all(50),
          margin: const EdgeInsets.all(10),
          child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: usernameCtrl,
                    keyboardType: TextInputType.number,
                    validator: _emailValidation,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        label: Text("Username"),
                        hintText: "username",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      controller: passwordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          label: Text("password"),
                          hintText: "password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      validator: _validatePass,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Account Type"),
                        DropdownButtonFormField(
                          hint: const Text('Select an account'),
                          value: accounTypeValue,
                          items: accountTypeList
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: _updateList,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text("Login"),
                  ),
                ],
              )),
        ));
  }

  String? _emailValidation(String? value) {
    if (value!.isEmpty) {
      return "email should not be empty!!";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(usernameCtrl.text)) {
      return "must be email format!";
    }
  }

  void _login() {
    if (_key.currentState!.validate()) {
      _messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text('Welcome: ${usernameCtrl.text}')));
    }
  }

  String? _validatePass(String? value) {
    if (value!.length <= 8 || value.isEmpty) {
      return 'Password must not be empty and greater than 8 charaters';
    }
  }

  String? _updateList(String? newValue) {
    if (newValue == 'Select an account') {
      return 'please select a choice';
    } else {
      setState(() {});
      accounTypeValue = newValue;
      return '';
    }
  }
}

List<String> accountTypeList = ['Basic', 'Pro', 'Premium'];
