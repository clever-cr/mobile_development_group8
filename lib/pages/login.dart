import 'package:flutter/material.dart';
import 'package:namer_app/components/button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("login")),
      body: Center(
          child: Button(
        buttonText: 'Login',
        onPressed: () {
          Navigator.pushNamed(context, '/quiz');
        },
      )),
    );
  }
}
