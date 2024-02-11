import 'package:flutter/material.dart';
import 'package:namer_app/components/button.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Center(
          child: Button(
        buttonText: 'start quiz',
        onPressed: () {
          Navigator.pushNamed(context, '/categories');
        },
      )),
    );
  }
}
