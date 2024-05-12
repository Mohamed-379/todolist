import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String label;
  TextFieldWidget({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Enter task $label",
        label: Text(
          label,
          style: const TextStyle(fontFamily: "Ubuntu", color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(width: 1, color: Colors.black54),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 2, color: Colors.black)),
      ),
      style: const TextStyle(fontFamily: "Ubuntu"),
      cursorColor: Colors.black,
      validator: (value) {
        if (controller.text.isEmpty) {
          return "$label is required";
        }
        return null;
      },
    );
  }
}