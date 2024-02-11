import 'package:flutter/material.dart';
import 'package:namer_app/components/button.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: Center(
          child: Button(
        buttonText: 'Choose category',
        onPressed: () {
          Navigator.pushNamed(context, '/questions');
        },
      )),
    );
  }
}
