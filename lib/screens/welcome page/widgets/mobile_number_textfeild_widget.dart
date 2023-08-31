
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sitare/constants/ui_constants.dart';

class MobileNumberTextFeildWidget extends StatelessWidget {
  const MobileNumberTextFeildWidget({
    super.key,
    required this.mobileNumberController,
  });

  final TextEditingController mobileNumberController;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: const TextStyle(color: FONT_COLOR),
      controller: mobileNumberController,
      initialCountryCode: 'IN',
      showDropdownIcon: false,
      
      cursorColor: FONT_COLOR,
      dropdownTextStyle: const TextStyle(color: FONT_COLOR),
      decoration: const InputDecoration(
        hintText: 'Mobile Number',
        hintStyle: TextStyle(color: FONT_COLOR),
        counterText: '',
        
      ),
    );
  }
}