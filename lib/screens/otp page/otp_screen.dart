import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/widgets/title_text_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

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
                onCompleted: (pin) {
                  //function here
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(), 
                  ));
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
