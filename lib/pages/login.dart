import 'package:flutter/material.dart';
import 'package:sharp_mind/components/button.dart';
import 'package:sharp_mind/components/text_field.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Field(
              hintText: 'Username',
              controller: TextEditingController(),
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20),
            Field(
              hintText: 'Password',
              controller: TextEditingController(),
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20),
            Button(
              buttonText: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
            ),
          ],
        ),
      ),
    );
  }
}
