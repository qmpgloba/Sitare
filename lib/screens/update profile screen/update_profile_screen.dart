import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/model/user_model.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/profile%20screen/widgets/update_profile_textfeild_widget.dart';
import 'package:sitare/widget/logger_widget.dart';

import '../create account page/cerate_account_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.email});
  final String? email;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameTextController = TextEditingController();

  TextEditingController emailTextController = TextEditingController();

  TextEditingController placeOfBirthTextController = TextEditingController();

  TextEditingController problemTextController = TextEditingController();

  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  String? genderDropDownValue;
  String? martialDropDownValue;
  TimeOfDay timeOfDay = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var genders = [
    'Male',
    'Female',
  ];

  var martialStatus = [
    'Single',
    'Married',
    'Divorced',
  ];
  @override
  void initState() {
    super.initState();

    controllersIntialization();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    String? number = FirebaseAuth.instance.currentUser == null
        ? ("+91${phoneNumberTextController.text}")
        : (FirebaseAuth.instance.currentUser!.phoneNumber);
    return FutureBuilder<DocumentSnapshot?>(
        future:
            getUserDataByPhoneNumber(number ??= phoneNumberTextController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            userData = snapshot.data!.data() as Map<String, dynamic>;
            logger.i("Entering");

            return Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                backgroundColor: PRIMARY_COLOR,
                title: const Text(
                  'Update Profile',
                  style:
                      TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: EdgeInsets.all(size.width / 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        UpdateProfileTextFeildWidgets(
                            size: size,
                            controller: nameTextController,
                            hintText: 'Full Name',
                            feildName: 'Name',
                            keyboardType: TextInputType.name),
                        const SizedBox(
                          height: 10,
                        ),
                        UpdateProfileTextFeildWidgets(
                          size: size,
                          readOnly: true,
                          controller: emailTextController,
                          hintText: 'Email',
                          feildName: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: size.width * .25,
                                child: const Text(
                                  'Gender',
                                  style: TextStyle(color: blackColor),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: size.width * .55,
                              height: 50,
                              child: DropdownButtonFormField(
                                value: genderDropDownValue ?? "Male",
                                hint: const Text(
                                  'Gender',
                                ),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder()),
                                // value: 'Male',
                                items: genders
                                    .map(
                                      (String items) => DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  genderDropDownValue = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: size.width * .25,
                                  child: const AutoSizeText(
                                    'Date of Birth',
                                    maxLines: 1,
                                    maxFontSize: 14,
                                    style: TextStyle(color: blackColor),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * .55,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(color: greyColor)),
                                  controller: dateInput,
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        dateInput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {}
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        UpdateProfileTextFeildWidgets(
                            size: size,
                            controller: placeOfBirthTextController,
                            hintText: 'Place of Birth',
                            feildName: 'Place of Birth',
                            keyboardType: TextInputType.name),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: size.width * .25,
                                  child: const AutoSizeText(
                                    'Time of Birth',
                                    maxLines: 1,
                                    maxFontSize: 14,
                                    style: TextStyle(color: blackColor),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * .55,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'Time of Birth',
                                      hintStyle: TextStyle(color: greyColor)),
                                  controller: timeInput,
                                  readOnly: true,
                                  onTap: () async {
                                    displayTimePicker(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: size.width * .25,
                                child: const AutoSizeText(
                                  'Martial Status',
                                  maxLines: 1,
                                  maxFontSize: 14,
                                  style: TextStyle(color: blackColor),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: size.width * .55,
                              height: 50,
                              child: DropdownButtonFormField(
                                value: martialDropDownValue ?? "Single",
                                hint: const AutoSizeText(
                                  'Martial status',
                                  maxLines: 1,
                                  maxFontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder()),
                                // value: 'Male',
                                items: martialStatus
                                    .map(
                                      (String items) => DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  martialDropDownValue = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        UpdateProfileTextFeildWidgets(
                            size: size,
                            controller: problemTextController,
                            hintText: 'Problem',
                            feildName: 'Problem',
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            logger.i(number);
                            if (_formKey.currentState!.validate()) {
                              UserModel user = UserModel(
                                name: nameTextController.text,
                                email: emailTextController.text,
                                phoneNumber: number ?? "",
                                gender: genderDropDownValue ?? "Male",
                                dateofBirth: dateInput.text,
                                placeofBirth: placeOfBirthTextController.text,
                                timeofBirth: timeInput.text,
                                maritalStatus: martialDropDownValue ?? "Single",
                                problem: problemTextController.text,
                              );
                              bool updateSuccess =
                                  await updateUser(user, number ?? "");
                              if (updateSuccess) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                              } else {
                                // showAboutDialog(context: context)
                              }
                            }
                          },
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(3)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: AutoSizeText(
                                'UPDATE',
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Text(number ?? "");
          }
        });
  }

  Future displayTimePicker(BuildContext context) async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (selectedTime != null) {
      final formattedTime = DateFormat.jm().format(
        DateTime(2023, 1, 1, selectedTime.hour, selectedTime.minute),
      );

      setState(() {
        timeInput.text = formattedTime;
      });
    }
  }

  controllersIntialization() {
    nameTextController = TextEditingController(
      text: userData!['full name'],
    );
    emailTextController = TextEditingController(
      text: userData!['email'],
    );
    placeOfBirthTextController = TextEditingController(
      text: userData!['placeofBirth'],
    );
    problemTextController = TextEditingController(
      text: userData!['problem'],
    );
    dateInput = TextEditingController(
      text: userData!['dateofBirth'],
    );
    timeInput = TextEditingController(
      text: userData!['timeofBirth'],
    );

    // genderDropDownValue = userData!['gender'];
    // martialDropDownValue = userData!['maritalStatus'];
  }
}

updateUser(UserModel user, String number) async {
  final db = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot = await db
        .collection('users')
        .where('phone number', isEqualTo: number)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      await documentSnapshot.reference.update(user.toJson());
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
