import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
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
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                    child: const Text(
                      "You must sign in to join ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person_add_sharp,
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
                      controller: emailController,
                      keyboardType: TextInputType.text,
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
                    const SizedBox(height: 20),
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
                    TextFormField(
                      validator: _validatePass,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.password,
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
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: const Alignment(1, 0),
                      padding: const EdgeInsets.only(top: 17, left: 20),
                      child: Row(
                        children: [
                          const Text(
                            'Doctor ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Checkbox(
                              value: _checkboxvalue,
                              onChanged: (newValue) =>
                                  oncheckboxchang(newValue)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // ElevatedButton(
                    //         onPressed: () {},
                    //         child: Text(
                    //       "Log In ",
                    //       style: TextStyle(
                    //           color: Colors.white, fontWeight: FontWeight.bold),
                    //     )
                    //       ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        _login();
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            // print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            // print('The account already exists for that email.');
                          }
                        } catch (e) {
                          // print(e);
                        }
                      },
                      color: const Color(0xff007F70),
                      // defining the shape
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                    // InkWell(
                    //   onTap:_login,
                    //   child: Container(
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       color: Color.fromRGBO(12, 134, 110, 1),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: const Center(
                    //       child: Text(
                    //       "Sign In ",
                    //       style: TextStyle(
                    //           color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                    //     )
                    //         ),
                    //   ),
                    // ),

                    // ElevatedButton(
                    // onPressed: _login,
                    // child: const Text("Login"),
                    //),
                    //Container(
                    //   height: 40,
                    //    child: Material(
                    //    borderRadius: BorderRadius.circular(20),
                    //  color: Color.fromARGB(255, 111, 146, 175),
                    //       elevation: 7,
                    //     child: GestureDetector(
                    //     onTap: () {
                    //     print('Log in ');
                    // },
                    //child: const Center(
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
                    const SizedBox(
                      height: 6.0,
                    ),
                    Container(
                      alignment: const Alignment(1, 0),
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("forgetpassword");
                        },
                        child: const Text(
                          'Forgot PassWord ? ',
                          style: TextStyle(
                            color: Color.fromRGBO(9, 123, 100, 1),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
                        children: [
                          const Text(
                            'Already have an Acccount ? ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("login");
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(9, 123, 100, 1),
                              ),
                            ),
                            // onTap: () {},
                            // child: Center(
                            //   child: Text.rich(TextSpan(children: [
                            //     TextSpan(text: "already have an account?"),
                            //     TextSpan(
                            //         text: "login",
                            //         style: TextStyle(
                            //             color: Color(0xff1f4172),
                            //             fontWeight: FontWeight.bold,
                            //             decoration: TextDecoration.underline))
                            //   ])),
                            // ),
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

  // ignore: body_might_complete_normally_nullable
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
    return null;
  }

  void _login() {
    if (_key.currentState!.validate()) {
      if (_checkboxvalue!) {
//
      } else {}
      _messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text('Welcome: ${emailController.text}')));
    }
  }
}
