import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../constants/ui_constants.dart';

class MobileNumberTextFeildWidget extends StatelessWidget {
   MobileNumberTextFeildWidget({
    super.key,
    required this.mobileNumberController,
    this.validator,
  });
  final TextEditingController mobileNumberController;
  final String? Function(String?)? validator;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: const TextStyle(color: FONT_COLOR),
      controller: mobileNumberController,
      initialCountryCode: 'IN',
      showDropdownIcon: false,
      validator: (value) {
        if (value != null || value == " ") {
          return 'Please enter your Mobile Number';
        }
        return null;
      },
      cursorColor: FONT_COLOR,
      // keyboardType: textin,
      dropdownTextStyle: const TextStyle(color: FONT_COLOR),
      decoration: const InputDecoration(
        hintText: 'Mobile Number',
        hintStyle: TextStyle(color: FONT_COLOR),
        counterText: '',
      ),
    );
  }
}
