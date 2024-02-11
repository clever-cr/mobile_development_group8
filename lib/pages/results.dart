import 'package:flutter/material.dart';
import 'package:namer_app/components/button.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Center(
          child: Button(
        buttonText: 'categories',
        onPressed: () {
          Navigator.pushNamed(context, '/quiz');
        },
      )),
    );
  }
}
