import 'package:flutter/material.dart';
import '../../../constants/ui_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.size,
    this.controller,
    required this.hintname,
    this.obscureText = false,
    this.validator,
    this.intialValue,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  final Size size;
  final TextEditingController? controller;
  final String hintname;
  final bool obscureText;
  final bool readOnly;
  final String? intialValue;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      readOnly: readOnly,
      obscureText: obscureText,
      style: const TextStyle(
        color: FONT_COLOR,
      ),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: hintname,
        hintStyle: const TextStyle(
          color: FONT_COLOR,
        ),
      ),
      validator: validator,
      initialValue: intialValue,
    );
  }
}
