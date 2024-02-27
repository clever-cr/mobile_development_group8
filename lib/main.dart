import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/quiz.dart';
import 'pages/categories.dart';
import 'pages/question.dart';
import 'pages/results.dart';
import 'pages/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      routes: {
        '/quiz': (context) => Quiz(),
        '/categories': (context) => Category(),
        '/questions': (context) => Question(),
        '/results': (context) => Result(),
        '/signUp': (context) => SignUp()
      },
    );
  }
}
