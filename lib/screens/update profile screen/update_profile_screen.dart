// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/main.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/model/user_model.dart';
import 'package:sitare/screens/chat%20screen/chat_screen.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/profile%20screen/widgets/update_profile_textfeild_widget.dart';
import 'package:sitare/screens/update%20profile%20screen/widgets/update_button_widget.dart';
import 'package:sitare/screens/update%20profile%20screen/widgets/logger_widget.dart';
import '../create account page/cerate_account_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({super.key, this.email, this.astrologer});

  final String? email;
  AstrologerModel? astrologer;

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
  String? imagePath;
  String? imageUrl;
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

  Future<void> imagePick() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked.path;
      });

      imageUrl = await addProfileImge(imagePicked);
    }
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
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage: imagePath == ''
                                  ? const AssetImage(
                                      'assets/images/profile_image.png',
                                    ) as ImageProvider
                                  : FileImage(File(imagePath!)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  imagePick();
                                },
                                child: const Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                        UpdateProfileTextFeildWidgets(
                          size: size,
                          controller: nameTextController,
                          hintText: 'Full Name',
                          feildName: 'Name',
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        UpdateProfileTextFeildWidgets(
                          size: size,
                          readOnly: false,
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
                              ),
                            ),
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
                                  border: UnderlineInputBorder(),
                                ),
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
                                ),
                              ),
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
                          keyboardType: TextInputType.name,
                        ),
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
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * .55,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Time of Birth',
                                    hintStyle: TextStyle(color: greyColor),
                                  ),
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
                                  border: UnderlineInputBorder(),
                                ),
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
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            logger.i(number);
                            if (_formKey.currentState!.validate()) {
                              UserModel user = UserModel(
                                fcmToken: fCMToken ?? 'error',
                                uid: currentUser!.uid,
                                name: nameTextController.text,
                                email: emailTextController.text,
                                phoneNumber: number ?? "",
                                userProfileImage: imageUrl ??= profileImage,
                                gender: genderDropDownValue ?? "Male",
                                dateofBirth: dateInput.text,
                                placeofBirth: placeOfBirthTextController.text,
                                timeofBirth: timeInput.text,
                                maritalStatus: martialDropDownValue ?? "Single",
                                problem: problemTextController.text,
                                wallet: '0.0',
                              );
                              bool updateSuccess =
                                  await updateUser(user, number ?? "");
                              if (updateSuccess && widget.astrologer == null) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                              } else if (updateSuccess &&
                                  widget.astrologer != null) {
                               userData =
                                    await getUserDataByuid(currentUser!.uid);
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      astrologer: widget.astrologer!),
                                ));
                                // showAboutDialog(context: context)
                              } else {}
                            }
                          },
                          child: const UpdateButtonWidget(),
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
    imagePath = userData!['profile image'] ??= profileImage;
    dateInput = TextEditingController(
      text: userData!['dateofBirth'],
    );
    timeInput = TextEditingController(
      text: userData!['timeofBirth'],
    );
  }
}
