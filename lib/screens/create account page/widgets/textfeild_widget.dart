import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';

// ignore: must_be_immutable
class TextfeildWidget extends StatelessWidget {
  TextfeildWidget(
      {super.key,
      required this.nameTextController,
      required this.text,
      required this.keyboardType,
      required this.obscureText,
      this.password});

  final TextEditingController nameTextController;
  final String text;
  final TextInputType keyboardType;
  final bool obscureText;
  TextEditingController? password;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: nameTextController,
      obscureText: obscureText,
      style: const TextStyle(color: FONT_COLOR),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(color: FONT_COLOR),
      ),
      validator: (value) {
        if (text == 'Email') {
          return validateEmail(value);
        } else if (text == 'Name') {
          return validateName(value);
        } else {
          return null;
        }
      },
    );
  }
}
