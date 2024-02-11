import 'package:flutter/material.dart';
import 'package:namer_app/components/button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Center(
          child: Button(
        buttonText: 'SignUp',
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
      )),
    );
  }
}
