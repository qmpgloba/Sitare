import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/welcome%20page/functions/functions.dart';
import 'package:sitare/screens/widgets/show_dialog_widget.dart';
import 'package:sitare/screens/widgets/title_text_widget.dart';

// ignore: must_be_immutable
class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  OtpFieldController otpController = OtpFieldController();
  String otp = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width / 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Text(
                  'SITARE',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
                ), SizedBox(height: size.width*.05),
              const TitleText(title: 'ENTER VERIFICATION CODE'),
              SizedBox(
                height: size.width * .15,
              ),
              OTPTextField(
                length: 6,
                width: size.width,
                fieldWidth: size.width / 8,
                style: const TextStyle(fontSize: 14),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.underline,
                controller: otpController,
                onCompleted: (pin) async {
                  
                  try {
                    await verifyOTP(pin).then((value) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                    });
                  // ignore: unused_catch_clause
                  } on FirebaseAuthException catch (e) {
                    showAlertBox(context, 'Invalid OTP', whiteColor, 'Close');
                  }
                  
                },
                otpFieldStyle: OtpFieldStyle(
                  enabledBorderColor: FONT_COLOR,
                  focusBorderColor: Colors.black,
                ),
              ),
              SizedBox(
                height: size.width * .12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont receive the OTP? ',
                    style: TextStyle(color: FONT_COLOR),
                  ),
                  GestureDetector(
                    onTap: () {
                      //add function here
                    },
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(color: redColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
