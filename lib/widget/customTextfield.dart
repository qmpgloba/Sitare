import 'package:flutter/material.dart';
import '../constants/app_constant.dart';
import '../constants/ui_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.size,
    required this.controller,
    required this.hintname,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  final String hintname;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: FONT_COLOR,
      ),
      decoration: InputDecoration(
        hintText: hintname,
        hintStyle: TextStyle(
          color: FONT_COLOR,
        ),
      ),
      validator: validator, 
    );
  }
}
