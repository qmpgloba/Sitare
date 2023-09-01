import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../constants/ui_constants.dart';

class MobileNumberTextFeildWidget extends StatelessWidget {
  MobileNumberTextFeildWidget({
    super.key,
    required this.mobileNumberController,
    this.validator,
    this.onCountryChanged,
  });
  final TextEditingController mobileNumberController;
  final String? Function(String?)? validator;
  final void Function(Country)? onCountryChanged;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: const TextStyle(color: FONT_COLOR),
      controller: mobileNumberController,
      initialCountryCode: 'IN',
      showDropdownIcon: false,
      onCountryChanged: onCountryChanged,
      validator: (value) {
        if (value != null || value == " ") {
          return 'Please enter your Mobile Number';
        }
        return null;
      },
      cursorColor: FONT_COLOR,
      // keyboardType: textin,
      dropdownTextStyle: const TextStyle(color: FONT_COLOR, fontSize:16),
      decoration: const InputDecoration(
        hintText: 'Mobile Number',
        hintStyle: TextStyle(color: FONT_COLOR),
        counterText: '',
      ),
    );
  }
}
