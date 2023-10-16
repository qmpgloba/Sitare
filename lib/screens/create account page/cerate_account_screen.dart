// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/model/user_model.dart';
import 'package:sitare/screens/enter%20details%20screen/enter_details_screen.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/welcome%20page/functions/functions.dart';
import 'package:sitare/screens/welcome%20page/welcome_screen.dart';
import 'package:sitare/screens/welcome%20page/widgets/mobile_number_textfeild_widget.dart';
import 'package:sitare/screens/widgets/auto_size_text_widget.dart';
import 'package:sitare/screens/widgets/show_dialog_widget.dart';
import 'package:sitare/screens/widgets/title_text_widget.dart';

import 'widgets/agreement_text_widget.dart';
import 'widgets/textfeild_widget.dart';

final TextEditingController emailTextController = TextEditingController();
final TextEditingController nameTextController = TextEditingController();
final TextEditingController phoneNumberTextController = TextEditingController();
 OtpFieldController otpController = OtpFieldController();
  String otp = '';

// ignore: must_be_immutable
class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String countyCode = '91';

  bool _isVisibleOTP =false;

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
                    text: 'Name',
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
                     controller: phoneNumberTextController,
                    onCountryChanged: (country) {
                      countyCode = country.dialCode;
                    },
                  ),
               
                  SizedBox(
                    height: size.width * .05,
                  ),
                  Visibility(
                    visible: _isVisibleOTP,
                    child: OTPTextField(
                                  length: 6,
                                  width: size.width,
                                  fieldWidth: size.width / 8,
                                  style: const TextStyle(fontSize: 14),
                                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                  fieldStyle: FieldStyle.underline,
                                  controller: otpController,
                                  onCompleted: (pin) async {
                    
                    try {
                      await verifyOTP(pin).then((value) async{
                         if (_formKey.currentState!.validate()) {
                            UserModel user = UserModel(
                              uid: '',
                                name: nameTextController.text,
                                email: emailTextController.text,
                                phoneNumber:
                                    "+91${phoneNumberTextController.text}",
                                    dateofBirth: '',
                                    gender: '',
                                    maritalStatus: '',
                                    partnerDetails: [],
                                    placeofBirth: '',
                                    problem: '',
                                    timeofBirth: '');
                            bool signedUp = await createUser(user);
                            if (signedUp) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => EnterDetailsScreen(
                                      phoneNumber: phoneNumberTextController.text,
                                     
                                    ),
                                  ),
                                  (route) => false);
                            } else {
                              showAboutDialog(context: context);
                            }
                          }
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) =>  EnterDetailsScreen(phoneNumber: phoneNumberTextController.text),
                        // ));
                      });
                    // ignore: unused_catch_clause
                    } on FirebaseAuthException catch (e) {
                      // ignore: use_build_context_synchronously
                      showAlertBox(context, 'Invalid OTP', whiteColor, 'Close');
                    }
                    
                                  },
                                  otpFieldStyle: OtpFieldStyle(
                    enabledBorderColor: FONT_COLOR,
                    focusBorderColor: Colors.black,
                                  ),
                                ),
                  ),
              SizedBox(
                    height: size.width * .05,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                       
                         if (phoneNumberTextController.text.isEmpty) {
                          showAlertBox(context, 'Please enter Mobile number',
                              whiteColor, 'Close');
                        } else {
                          if (_formKey.currentState!.validate()) {
                            var phoneNumber =
                                '+$countyCode${phoneNumberTextController.text}';
                            // bool mobileNumberExists =
                            //     await checkPhoneNumberExistence(phoneNumber);
                       
                              var result =
                                  await phoneAuthentication(phoneNumber);
                              if (result == null) {
                                // showSnackbar(
                                //     context, 'OTP sent Succesfully', greenColor);
                                // ignore: use_build_context_synchronously
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => OTPScreen(),
                                // ));
                                 setState(() {
                          _isVisibleOTP =true;
                        });
                              } else {
                                // ignore: use_build_context_synchronously
                                showAlertBox(
                                    context, result, whiteColor, 'close');
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              showAlertBox(
                                  context,
                                  'Enter a valid mobile number',
                                  whiteColor,
                                  'Retry');
                            }
                       
                        }
                        // if (_formKey.currentState!.validate()) {
                        //   UserModel user = UserModel(
                        //       name: nameTextController.text,
                        //       email: emailTextController.text,
                        //       phoneNumber:
                        //           "+91${phoneNumberTextController.text}",
                        //           dateofBirth: '',
                        //           gender: '',
                        //           maritalStatus: '',
                        //           partnerDetails: [],
                        //           placeofBirth: '',
                        //           problem: '',
                        //           timeofBirth: '');
                        //   bool signedUp = await createUser(user);
                        //   if (signedUp) {
                        //     // ignore: use_build_context_synchronously
                        //     Navigator.of(context).pushAndRemoveUntil(
                        //         MaterialPageRoute(
                        //           builder: (context) => EnterDetailsScreen(
                        //             phoneNumber: phoneNumberTextController.text,
                                   
                        //           ),
                        //         ),
                        //         (route) => false);
                        //   } else {
                        //     showAboutDialog(context: context);
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


