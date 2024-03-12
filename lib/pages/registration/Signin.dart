import 'package:flutter/material.dart';
import 'package:gemp/api/API.dart';
import 'package:gemp/pages/Home.dart';

import 'register.dart';
//import 'package:gemp/pages/Signup.dart'; // Importez la page d'inscription

final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
final String emailFormat = 'Enter a valid email address';
final String passwordFormat = 'Use a-z | A-Z | 0-9';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _signinFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _signinFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  // Validation logic
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  // Validation logic
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : login,
                child: _isLoading ? CircularProgressIndicator() : Text('Sign in'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  //Navigation vers la page d'inscription
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()), // Assurez-vous que Signup est bien défini
                  );
                },
                child: Text('Create an account'), // Texte du lien vers la page d'inscription
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (_signinFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> data = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      // Call loginData
      await loginData('login/', data);

      setState(() {
        _isLoading = false;
      });

      // Handle navigation after login
      // For example:
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
