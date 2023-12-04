// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/functions/details%20functions/details_functions.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/main.dart';
import 'package:sitare/model/user_model.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/details_widget.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({
    super.key,
    required this.phoneNumber,
    required this.name,
    this.email,
  });
  final String phoneNumber;
  final String name;
  final String? email;
  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  int length = 1;
  TextEditingController emailController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pobController = TextEditingController();
  TextEditingController tobController = TextEditingController();
  TextEditingController martialController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  final _key = GlobalKey<FormState>();

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
              child: DetailsWidget(
                size: size,
                name: widget.name,
                emailController: emailController,
                mobileNumber: widget.phoneNumber,
                dobController: dobController,
                pobController: pobController,
                tobController: tobController,
                problemController: problemController,
                optionalField: optionalField,
                genderController: genderController,
                martialController: martialController,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: onSubmit(size, context),
    );
  }

  addUserDetails({
    required BuildContext context,
    required String name,
    required String mobile,
  }) async {
    UserModel user = UserModel(
      fcmToken: fCMToken ?? 'error',
      uid: currentUser!.uid,
      name: name,
      phoneNumber: "+91$mobile",
      userProfileImage: profileImage,
      gender: '',
      dateofBirth: '',
      placeofBirth: '',
      timeofBirth: '',
      maritalStatus: '',
      problem: '',
      partnerDetails: optionalField,
      wallet: '0.0',
    );

    await updateUser(user, '+91$mobile');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  onSubmit(Size size, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.08,
        right: size.width * 0.08,
        top: size.height * 0.02,
        bottom: size.height * 0.02,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              _key.currentState?.validate();

              if (_key.currentState != null &&
                  _key.currentState!.validate() &&
                  problemController.text.isNotEmpty &&
                  martialController.text.isNotEmpty &&
                  pobController.text.isNotEmpty &&
                  genderController.text.isNotEmpty &&
                  dobController.text.isNotEmpty &&
                  tobController.text.isNotEmpty) {
                _key.currentState!.save();
                UserModel user = UserModel(
                  fcmToken: fCMToken ?? 'error',
                  uid: currentUser!.uid,
                  name: widget.name,
                  email: widget.email,
                  phoneNumber: "+91${widget.phoneNumber}",
                  userProfileImage: profileImage,
                  gender: genderController.text,
                  dateofBirth: dobController.text,
                  placeofBirth: pobController.text,
                  timeofBirth: tobController.text,
                  maritalStatus: martialController.text,
                  problem: problemController.text,
                  partnerDetails: optionalField,
                  wallet: '0.0',
                );
                bool submitSuccess = await updateUser(
                    user, "+91${phoneNumberTextController.text}");
                if (submitSuccess) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                }
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
                  context: context,
                  name: widget.name,
                  mobile: widget.phoneNumber,
                );
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
}
