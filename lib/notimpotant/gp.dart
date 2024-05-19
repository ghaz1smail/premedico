import 'package:flutter/material.dart';

void main() {
  runApp(SignUpPage());
}

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

class _SignUpFormState extends State<SignUpForm> {
  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController =
  //     TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        //key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              //controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              
            ),
            TextFormField(
              //controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              
            ),
            TextFormField(
              //controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              
            ),
            TextFormField(
              
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}