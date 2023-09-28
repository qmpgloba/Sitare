import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/welcome%20page/widgets/mobile_number_textfeild_widget.dart';
import 'package:sitare/widget/custom_textfield.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({super.key});

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  int length = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pobController = TextEditingController();
  TextEditingController tobController = TextEditingController();
  TextEditingController martialController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  String countrycode = "91";
  bool tobDone = false;
  bool dobDone = false;
  bool timeChanged = false;
  List<String> optionalField = [];
  final _key = GlobalKey<FormState>();
  String? _gender;
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');

  Future<void> create() async {
    Map<String, dynamic> addData = {
      "name": nameController.text.toString(),
      "email": emailController.text.toString(),
      "gender": genderController.text.toString(),
      "DOB": dobController.text.toString(),
      "POB": pobController.text.toString(),
      "TOB": tobController.text.toString(),
      "marital_status": martialController.text.toString(),
      "problem": problemController.text.toString(),
      "phone_number": "+$countrycode${mobileNumberController.text}",
    };

    for (int i = 0; i < length; i++) {
      addData["PartnerDetails$i"] = optionalField[i].toString();
    }

    await _user.add(addData);
  }

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
        tobController.text = time.format(context);
        tobDone = true;
      });
    }
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
                    controller: nameController,
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
                  MobileNumberTextFeildWidget(
                    mobileNumberController: mobileNumberController,
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
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: () {
                      _showDatePicker();
                    },
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: FONT_COLOR,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
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
                      height: size.height * 0.06,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: FONT_COLOR,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
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
                  ),
                  CustomTextField(
                    size: size,
                    controller: martialController,
                    hintname: "Maritial Status",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Maritial Status';
                      }
                      return null;
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
              onTap: () {
                _key.currentState!.validate();
                if (_key.currentState!.validate() &&
                    _gender != null &&
                    mobileNumberController.text.isNotEmpty &&
                    dobDone &&
                    tobDone) {
                  _key.currentState!.save();
                  create();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
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
          height: 16,
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
                  hint: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: Text(
                      label,
                      style: const TextStyle(
                        // fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: FONT_COLOR,
                      ),
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

  Container dateofBirth() {
    // ignore: avoid_unnecessary_containers
    return Container(
      // width: 160

      child: TextFormField(
        controller: dobController,
        style: const TextStyle(
          color: FONT_COLOR,
        ),
        decoration: const InputDecoration(
          hintText: "DD/MM/YYYY",
          hintStyle: TextStyle(
            color: FONT_COLOR,
            fontWeight: FontWeight.w700,
          ),
          label: Text(
            "Date of Birth",
            style: TextStyle(
              color: FONT_COLOR,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        validator: (v) {
          final RegExp regex = RegExp(
              r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/(19[0-9]{2}|20[0-2][0-9]|2023)$');

          if (v != null) {
            if (!regex.hasMatch(v)) {
              return "Enter in the format of DD/MM/YYYY";
            }
          }
          return null;
        },
      ),
    );
  }
}
