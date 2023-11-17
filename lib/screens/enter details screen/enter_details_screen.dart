// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/details%20functions/date_time_functions.dart';
import 'package:sitare/functions/details%20functions/details_functions.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/dob_field.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/drop_down.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/partner_details.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/custom_textfield.dart';
import '../welcome page/widgets/mobile_number_textfeild_widget.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({
    super.key,
    required this.phoneNumber,
  });
  final String phoneNumber;

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  int length = 1;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileNumberController;
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pobController = TextEditingController();
  TextEditingController tobController = TextEditingController();
  TextEditingController martialController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  String countrycode = "91";
  List<String> optionalField = [];
  final _key = GlobalKey<FormState>();
  String? name;
  String? _martialStatus;
  String? phoneNumber;
  String? email;

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await datePicker(context);
    if (pickedDate != null) {
      setState(() {
        dobController.text =
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
        tobController.text = time.format(context);
        tobDone = true;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      nameController = TextEditingController(text: nameTextController.text);
      mobileNumberController = TextEditingController(text: widget.phoneNumber);
      emailController = TextEditingController(text: emailTextController.text);
      email = emailTextController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                top: size.height * 0.02,
                bottom: size.height * 0.01,
              ),
              child: Column(
                children: [
                  const Text(
                    'SITARE',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(height: size.width * .05),
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
                    size: size,
                    readOnly: true,
                    controller: nameController,
                    // ignore: body_might_complete_normally_nullable
                    onChanged: (value) {
                      setState(() {
                        name = value ?? "";
                      });
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
                    size: size,
                    readOnly: true,
                    controller: emailController,
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
                    controller: mobileNumberController,
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
                        genderController.text = v ?? "";
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
                    child: DobField(dobController: dobController),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    size: size,
                    controller: pobController,
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
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: whiteColor, width: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Time of Birth: ${tobController.text}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: FONT_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        martialController.text = v ?? "";
                      });
                    },
                    dropDownCategory: _martialStatus,
                    dropDownValue: martialStatus,
                  ),
                  CustomTextField(
                    size: size,
                    controller: problemController,
                    hintname: "Problem",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Problem';
                      }
                      return null;
                    },
                  ),
                  PartnerDetailsWidget(
                    size: size,
                    length: length,
                    optionalField: optionalField,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: onSubmit(
        size: size,
        context: context,
        name: nameController.text,
        email: emailController.text,
        mobile: phoneNumberTextController.text,
        gender: genderController.text,
        dob: dobController.text,
        pob: pobController.text,
        tob: tobController.text,
        maritalStatus: martialController.text,
        problem: problemController.text,
      ),
    );
  }
}
