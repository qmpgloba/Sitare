import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/details%20functions/date_time_functions.dart';
import 'package:sitare/functions/details%20functions/details_functions.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/custom_textfield.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/dob_field.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/drop_down.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/partner_details.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/tob_widget.dart';
import 'package:sitare/screens/welcome%20page/widgets/mobile_number_textfeild_widget.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({
    super.key,
    required this.size,
    required this.nameController,
    required this.emailController,
    required this.mobileNumberController,
    required this.dobController,
    required this.pobController,
    required this.tobController,
    required this.problemController,
    required this.optionalField,
    required this.genderController,
    required this.martialController,
  });

  final Size size;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileNumberController;
  final TextEditingController dobController;
  final TextEditingController pobController;
  final TextEditingController tobController;
  final TextEditingController problemController;
  final TextEditingController genderController;
  final TextEditingController martialController;

  final List<String> optionalField;

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  String countrycode = "91";
  List<String> optionalField = [];
  String? name;
  String? _martialStatus;
  String? phoneNumber;
  String? email;
  bool tobDone = false;
  bool dobDone = false;
  bool timeChanged = false;
  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await datePicker(context);
    if (pickedDate != null) {
      setState(() {
        widget.dobController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
        dobDone = true;
      });
    }
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await timePicker(context);
    if (pickedTime != null && pickedTime != time) {
      setState(() {
        time = pickedTime; // Update the time variable
        widget.tobController.text = time.format(context);
        tobDone = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'SITARE',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
        SizedBox(height: widget.size.width * .05),
        const Center(
          child: Text(
            "ENTER DETAILS",
            style: TextStyle(
              color: FONT_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        CustomTextField(
          size: widget.size,
          // readOnly: true,
          controller: widget.nameController,
          onChanged: (value) {
            setState(() {
              name = value ?? "";
            });
            return null;
          },
          hintname: "Name",
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        CustomTextField(
          size: widget.size,
          // readOnly: true,
          controller: widget.emailController,
          hintname: "Email",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!value.contains('@')) {
              return 'Invalid email format';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 5,
        ),
        MobileNumberTextFeildWidget(
          controller: widget.mobileNumberController,
          readOnly: false,
          onCountryChanged: (v) {
            setState(() {
              countrycode = v.dialCode;
            });
          },
        ),
        DropDown(
          context: context,
          label: 'Gender',
          onChanged: (v) {
            setState(() {
              gender = v ?? "";
              widget.genderController.text = v ?? "";
            });
          },
          dropDownCategory: gender,
          dropDownValue: GENDERS,
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            _showDatePicker();
          },
          child: DobField(dobController: widget.dobController),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          size: widget.size,
          controller: widget.pobController,
          hintname: "Place of Birth",
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your Place of Birth';
            }
            return null;
          },
        ),
        const SizedBox(height: 25),
        InkWell(
          onTap: () {
            _showTimePicker();
          },
          child: TobWidget(tobController: widget.tobController),
        ),
        const SizedBox(
          height: 5,
        ),
        DropDown(
          context: context,
          label: "Martial Status",
          onChanged: (v) {
            setState(() {
              _martialStatus = v ?? "";
              widget.martialController.text = v ?? "";
            });
          },
          dropDownCategory: _martialStatus,
          dropDownValue: martialStatus,
        ),
        CustomTextField(
          size: widget.size,
          controller: widget.problemController,
          hintname: "Problem",
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your Problem';
            }
            return null;
          },
        ),
        PartnerDetailsWidget(
          size: widget.size,
          optionalField: widget.optionalField,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
