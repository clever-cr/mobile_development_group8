import 'package:flutter/material.dart';
import 'package:sharp_mind/components/button.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bingo!", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Button(
                buttonText: 'categories',
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
