import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/welcome%20page/widgets/mobile_number_textfeild_widget.dart';
import 'package:sitare/widget/custom_textfield.dart';

import '../../model/user_model.dart';

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

  TimeOfDay time = TimeOfDay.now();
  String countrycode = "91";
  bool tobDone = false;
  bool dobDone = false;
  bool timeChanged = false;
  List<String> optionalField = [];
  final _key = GlobalKey<FormState>();
  String? _gender;
  String? _martialStatus;
  String? name;
  String? phoneNumber;
  String? email;

  
  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
        dobDone = true;
      });
    }
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

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
                        color: whiteColor),
                  ),
                  SizedBox(height: size.width * .05),
                  const Center(
                    child: Text(
                      "ENTER DETAILS",
                      style: TextStyle(
                          color: FONT_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
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
                  _genderDropDown(
                    label: "Gender",
                    onChanged: (v) {
                      setState(() {
                        _gender = v ?? "";
                        genderController.text = v ?? "";
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _showDatePicker();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: whiteColor, width: 0.4),
                      )),
                      child: Row(
                        children: [
                          Text(
                            "Date of Birth: ${dobController.text} ",
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
                              bottom:
                                  BorderSide(color: whiteColor, width: 0.4))),
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
                  _martialDropDown(
                    label: "Martial Status",
                    onChanged: (v) {
                      setState(() {
                        _martialStatus = v ?? "";
                        martialController.text = v ?? "";
                      });
                    },
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
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    shrinkWrap: true,
                    itemCount: length,
                    itemBuilder: (context, index) {
                      if (optionalField.length <= index) {
                        optionalField.add('');
                      }

                      return TextFormField(
                        style: const TextStyle(
                          color: FONT_COLOR,
                        ),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            hintText: "Partner Details (Optional)",
                            hintStyle: const TextStyle(
                              color: FONT_COLOR,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: whiteColor,
                              ),
                            ),
                            suffixIcon: index == 0
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        ++length;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: FONT_COLOR,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        --length;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: FONT_COLOR,
                                    ),
                                  )),
                        onChanged: (v) {
                          optionalField[index] = v;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.08,
            right: size.width * 0.08,
            top: size.height * 0.02,
            bottom: size.height * 0.02),
        child: Wrap(
          // mainAxisAlignment: MainAxisAlignment.end,
          alignment: WrapAlignment.center,
          // crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                _key.currentState!.validate();
                if (_key.currentState!.validate() &&
                    _gender != null &&
                    mobileNumberController.text.isNotEmpty &&
                    dobDone &&
                    tobDone) {
                  _key.currentState!.save();
                  UserModel user = UserModel(
                      name: nameController.text,
                      email: emailController.text,
                      phoneNumber: phoneNumberTextController.text,
                      gender: genderController.text,
                      dateofBirth: dobController.text,
                      placeofBirth: pobController.text,
                      timeofBirth: tobController.text,
                      maritalStatus: martialController.text,
                      problem: problemController.text,
                      partnerDetails: optionalField);
                  bool submitSuccess =
                      await updateUser(user, emailController.text);
                  if (submitSuccess) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
                  } else {
                    // showAboutDialog(context: context)
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Validation Error'),
                        content: const Text(
                            'Please fill out all required fields correctly.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text(
                "SUBMIT",
                style:
                    TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                },
                child: const Row(
                  children: [
                    Text(
                      "SKIP FOR NOW",
                      style: TextStyle(
                          fontSize: 14,
                          color: FONT_COLOR,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: FONT_COLOR,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  Column _genderDropDown(
      {required String label, required Function(String?) onChanged}) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(
                  //   color: FONT_COLOR,
                  // ),
                ),
                height: size.height * 0.06,
                child: DropdownButton<String>(
                  dropdownColor: PRIMARY_COLOR,
                  value: _gender,
                  // underline: const SizedBox(),
                  hint: Text(
                    label,
                    style: const TextStyle(
                      // fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: FONT_COLOR,
                    ),
                  ),
                  items: GENDERS.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: Text(
                          value,
                          style: const TextStyle(color: FONT_COLOR),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  isExpanded: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _martialDropDown(
      {required String label, required Function(String?) onChanged}) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(
                  //   color: FONT_COLOR,
                  // ),
                ),
                height: size.height * 0.06,
                child: DropdownButton<String>(
                  dropdownColor: PRIMARY_COLOR,
                  value: _martialStatus,
                  // underline: const SizedBox(),
                  hint: Text(
                    label,
                    style: const TextStyle(
                      // fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: FONT_COLOR,
                    ),
                  ),
                  items: martialStatus.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: Text(
                          value,
                          style: const TextStyle(color: FONT_COLOR),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  isExpanded: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
}

