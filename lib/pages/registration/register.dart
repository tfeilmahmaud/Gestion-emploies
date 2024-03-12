import 'package:flutter/material.dart';
import 'package:gemp/api/API.dart'; // Importez votre fichier d'API pour les appels réseau

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _signupFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _signupFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [   TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
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
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : signUp,
                child: _isLoading ? CircularProgressIndicator() : Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    if (_signupFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> data = {
        'email': emailController.text,
        'username': usernameController.text,
        'password': passwordController.text,
      };

      // Effectuez votre appel d'API pour le processus d'inscription
     // await registerUser(data);

      setState(() {
        _isLoading = false;
      });

      // Après l'inscription, vous pouvez effectuer une action comme rediriger l'utilisateur vers une autre page
      // Par exemple :
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
