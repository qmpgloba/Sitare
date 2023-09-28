import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/model/user_model.dart';
import 'package:sitare/screens/enter%20details%20screen/enter_details_screen.dart';
import 'package:sitare/screens/welcome%20page/welcome_screen.dart';
import 'package:sitare/screens/welcome%20page/widgets/mobile_number_textfeild_widget.dart';
import 'package:sitare/screens/widgets/auto_size_text_widget.dart';
import 'package:sitare/screens/widgets/title_text_widget.dart';

import 'widgets/agreement_text_widget.dart';
import 'widgets/textfeild_widget.dart';

// ignore: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});
  final TextEditingController emailTextController = TextEditingController();
  // final TextEditingController passwordTextController = TextEditingController();
  // final TextEditingController confirmPasswordTextController =
  //     TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  String countyCode = '91';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width / 14),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'SITARE',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                  SizedBox(height: size.width * .05),
                  const TitleText(title: 'CREATE ACCOUNT'),
                  SizedBox(
                    height: size.width * .18,
                  ),
                  TextfeildWidget(
                    nameTextController: nameTextController,
                    keyboardType: TextInputType.text,
                    text: 'name',
                    obscureText: false,
                    // validate: validatePassword,
                  ),
                  SizedBox(
                    height: size.width * .07,
                  ),
                  TextfeildWidget(
                    nameTextController: emailTextController,
                    keyboardType: TextInputType.name,
                    text: 'Email',
                    obscureText: false,
                    // validate: validateEmail,
                  ),
                  SizedBox(
                    height: size.width * .07,
                  ),
                  MobileNumberTextFeildWidget(
                    mobileNumberController: phoneNumberTextController,
                    onCountryChanged: (country) {
                      countyCode = country.dialCode;
                    },
                  ),
                  // TextfeildWidget(
                  //   nameTextController: phoneNumberTextController,
                  //   keyboardType: TextInputType.phone,
                  //   text: 'Phone Number',
                  //   obscureText: false,
                  //   // password: passwordTextController,
                  // ),
                  SizedBox(
                    height: size.width * .15,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          UserModel _user = UserModel(
                              name: nameTextController.text,
                              email: emailTextController.text,
                              phoneNumber: "+91"+phoneNumberTextController.text);
                          bool signedUp = await createUser(_user);
                          if (signedUp) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => EnterDetailsScreen(),
                                ),
                                (route) => false);
                          } else {
                            print('failed');
                            // showAboutDialog(context: context)
                          }
                        }
                        // if (_formKey.currentState!.validate()) {
                        //   var result = await signUpWithEmail(
                        //       email: emailTextController.text.trim(),
                        //       password: passwordTextController.text.trim());
                        //   if (result == null) {
                        //     //Navigate the screen
                        //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const EnterDetailsScreen(),), (route) => false);
                        //   } else {
                        //     // showToast(signUpSuccess, redColor);
                        //     // showSnackbar(context, signUpSuccess, redColor);
                        //     // ignore: use_build_context_synchronously
                        //     showAlertBox(
                        //         context, result, whiteColor, 'Retry');
                        //   }
                        // }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(PRIMARY_COLOR),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                            color: FONT_COLOR,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(color: FONT_COLOR),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * .07,
                  ),
                  AgreementTextWidget(size: size),
                  SizedBox(
                    height: size.width * .2,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ));
                    },
                    child: const AutoSizeTextWidget(
                        text: 'Already registered. Sign in with OTP',
                        maxLines: 1,
                        fontSize: 16,
                        fontColor: FONT_COLOR),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

createUser(UserModel user) async {
  final db = FirebaseFirestore.instance;

  try {
    await db.collection('users').add(
          user.toJson(),
        );
        return true;
    // ignore: empty_catches
  } catch (e) {
    return false;
  }
}
