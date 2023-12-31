import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';

import '../../../constants/ui_constants.dart';

class UpdateProfileTextFeildWidgets extends StatelessWidget {
  const UpdateProfileTextFeildWidgets(
      {super.key,
      required this.size,
      required this.controller,
      required this.hintText,
      required this.feildName,
      required this.keyboardType,
      this.readOnly = false});

  final Size size;
  final bool readOnly;
  final TextEditingController controller;
  final String hintText;
  final String feildName;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: size.width * .25,
              child: AutoSizeText(
                feildName,
                maxLines: 1,
                maxFontSize: 16,
                style: const TextStyle(color: blackColor),
              )),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: size.width * .55,
            height: 35,
            child: TextFormField(
              readOnly: readOnly,
              keyboardType: keyboardType,
              controller: controller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: FONT_COLOR),
              ),
              validator: (value) {
                if (hintText == 'Email') {
                  return validateEmail(value);
                } else {
                  return value!.isEmpty ? 'Please fill the feild' : null;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
