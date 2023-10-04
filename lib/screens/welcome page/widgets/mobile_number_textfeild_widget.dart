import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sitare/constants/ui_constants.dart';

class MobileNumberTextFeildWidget extends StatelessWidget {
  const MobileNumberTextFeildWidget({
    super.key,
    this.mobileNumberController,
    this.validator,
    this.onCountryChanged,
    this.intialValue,
    this.onChanged,
    this.readOnly = false,
  });
  final TextEditingController? mobileNumberController;
  final String? Function(String?)? validator;
  final String? Function(PhoneNumber?)? onChanged;
  final void Function(Country)? onCountryChanged;
  final String? intialValue;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: const TextStyle(color: FONT_COLOR),
      controller: mobileNumberController,
      readOnly: readOnly,
      initialCountryCode: 'IN',
      showDropdownIcon: false,
      onCountryChanged: onCountryChanged,
      onChanged: onChanged,
      cursorColor: FONT_COLOR,
      initialValue: intialValue,
      // keyboardType: textin,
      dropdownTextStyle: const TextStyle(color: FONT_COLOR),
      decoration: const InputDecoration(
        hintText: 'Mobile Number',
        hintStyle: TextStyle(color: FONT_COLOR),
        counterText: '',
      ),
      // validator: (value) {
      //   if(value!.isValidNumber()){

      //   }else{
      //     return 'Please enter valid number';
      //   }
      // },
    );
  }
}
