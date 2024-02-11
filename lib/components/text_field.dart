import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const Field(
      {Key? key,
      required this.hintText,
      required this.controller,
      required InputDecoration decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
