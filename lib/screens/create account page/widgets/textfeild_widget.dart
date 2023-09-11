import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/create%20account%20page/functions/functions.dart';

// ignore: must_be_immutable
class TextfeildWidget extends StatelessWidget {
   TextfeildWidget({
    super.key,
    required this.nameTextController,
    required this.text,
    required this.keyboardType,
    required this.obscureText,
     this.password
     
  });

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
        if(text == 'Email'){
          return validateEmail(value);
        }else if(text == 'Password'){
          return validatePassword(value);
        }else if(text == 'Confirm Password'){
          return validateConfirmPassword(value, password?.text.trim());
        }else{
          return null;
        }
      },
    );
  }

}


