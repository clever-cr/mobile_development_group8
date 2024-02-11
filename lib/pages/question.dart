import 'package:flutter/material.dart';
import 'package:sharp_mind/components/button.dart';

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions")),
      body: Center(
          child: Button(
        buttonText: 'Submit',
        onPressed: () {
          Navigator.pushNamed(context, '/results');
        },
      )),
    );
  }
}
