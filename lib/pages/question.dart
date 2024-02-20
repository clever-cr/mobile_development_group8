import 'package:flutter/material.dart';
import 'package:sharp_mind/components/button.dart';

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions")),
      body: Center(
          child: Column(
        children: [
          Text("What is a controller in Next js"),
          Button(
            buttonText: 'A steel wheel',
            onPressed: () {
              Navigator.pushNamed(context, '/results');
            },
          ),
          Button(
            buttonText: 'A Ballon',
            onPressed: () {
              Navigator.pushNamed(context, '/results');
            },
          ),
          Button(
            buttonText: 'An adapter to the business logic',
            onPressed: () {
              Navigator.pushNamed(context, '/results');
            },
          ),
          Button(
            buttonText: 'None of the above',
            onPressed: () {
              Navigator.pushNamed(context, '/results');
            },
          ),
        ],
      )),
    );
  }
}
