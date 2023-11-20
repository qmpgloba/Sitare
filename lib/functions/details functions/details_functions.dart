// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/model/user_model.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';

bool timeChanged = false;
List<String> optionalField = [];
// final _key = GlobalKey<FormState>();
String? gender;

onSubmit(
    {required Size size,
    required BuildContext context,
    required String name,
    required String email,
    required String mobile,
    required String gender,
    required String dob,
    required String pob,
    required String tob,
    required String maritalStatus,
    required String problem,
    required GlobalKey<FormState> key}) {
  return Padding(
    padding: EdgeInsets.only(
        left: size.width * 0.08,
        right: size.width * 0.08,
        top: size.height * 0.02,
        bottom: size.height * 0.02),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            key.currentState?.validate();

            if (key.currentState != null &&
                key.currentState!.validate() &&
                dob.isNotEmpty &&
                tob.isNotEmpty) {
              key.currentState!.save();
              UserModel user = UserModel(
                uid: currentUser!.uid,
                name: name,
                email: email,
                phoneNumber: "+91$mobile",
                userProfileImage: profileImage,
                gender: gender,
                dateofBirth: dob,
                placeofBirth: pob,
                timeofBirth: tob,
                maritalStatus: maritalStatus,
                problem: problem,
                partnerDetails: optionalField,
              );
              // print(user.partnerDetails);
              // bool submitSuccess = await updateUser(user, "+91$mobile");
              // if (submitSuccess) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
              // } else {
              //   print('Error');
              // }
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Validation Error'),
                    content:
                        const Text('Please fill out all required fields .'),
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
            style: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: InkWell(
            onTap: () async {
              addUserDetails(
                  context: context, name: name, mobile: mobile, email: email);
            },
            child: const Row(
              children: [
                Text(
                  "SKIP FOR NOW",
                  style: TextStyle(
                    fontSize: 14,
                    color: FONT_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
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
      ],
    ),
  );
}

addUserDetails(
    {required BuildContext context,
    required String name,
    required String mobile,
    required String email}) async {
  UserModel user = UserModel(
      uid: currentUser!.uid,
      name: name,
      email: email,
      phoneNumber: "+91$mobile",
      userProfileImage: profileImage,
      gender: '',
      dateofBirth: '',
      placeofBirth: '',
      timeofBirth: '',
      maritalStatus: '',
      problem: '',
      partnerDetails: optionalField);
  await updateUser(user, '+91$mobile');
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
    (route) => false,
  );
}
