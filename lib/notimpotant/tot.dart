// ignore_for_file: unused_import, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/notimpotant/main.dart';

void main() {
  runApp(SignUpPage());
}
final _messengerKey = GlobalKey<ScaffoldMessengerState>();
class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}
//bool styleIOS = true;
class _SignUpFormState extends State<SignUpForm> {
  final _Key = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              
                    keyboardType: TextInputType.text,
                    
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person_2,
                        size: 18,
                      ),
                      hintText: "Enter Your username",
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'UserName',
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
              validator: _validatePass,
            ),
            TextFormField(
              controller: _emailController,
              //validator:_emailValidation ,
              
                    keyboardType: TextInputType.number,
                    
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
            TextFormField(
              controller: _passwordController,
              validator: (_validatePass) ,
                    keyboardType: TextInputType.number,
                    // validator: _emailValidation,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mail_sharp,
                        size: 18,
                      ),
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'Password',
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
              obscureText: true,
              
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mail_sharp,
                        size: 18,
                      ),
                      hintText: "Confirm Your Password",
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Color.fromARGB(255, 145, 138, 138),
                      ),
                      labelText: 'Confirm Password',
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
              obscureText: true,
              
            ),
            SizedBox(height: 20),
            
            ElevatedButton(
              onPressed:_login ,

                // if (_formKey.currentState.validate()) {
                //   // Perform sign-up operation here
                //   // For demonstration purposes, just print the values
                //   print('Username: ${_usernameController.text}');
                //   print('Email: ${_emailController.text}');
                //   print('Password: ${_passwordController.text}');
                //   print('Confirm Password: ${_confirmPasswordController.text}');
                // }
              
              child:Text('Sign Up'),
              
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _usernameController.dispose();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   super.dispose();
  // }
  void _login() {
    if (_Key.currentState!.validate()) {
      _messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text('Welcome: ${_usernameController.text}')));
    }
}
String? _validatePass(String? value) {
    if (value!.isEmpty) {
      return 'Password must not be empty and greater than 8 charaters';
    }
  }
}
// String? _emailValidation(String? value) {
//     if (value!.isEmpty) {
//       return "email should not be empty!!";
//     } else if (!RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//         .hasMatch(_usernameController.text)) {
//       return "must be email format!";
//     }
//   }