import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/otp%20page/otp_screen.dart';
import 'package:sitare/screens/welcome%20page/functions/functions.dart';
import 'package:sitare/screens/welcome%20page/widgets/mobile_number_textfeild_widget.dart';
import 'package:sitare/screens/widgets/show_dialog_widget.dart';
import 'package:sitare/screens/widgets/title_text_widget.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width / 14),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TitleText(title: 'WELCOME'),
                  SizedBox(
                    height: size.width * .2,
                  ),
                  MobileNumberTextFeildWidget(
                      mobileNumberController: mobileNumberController),
                  SizedBox(
                    height: size.width / 14,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (mobileNumberController.text.isEmpty) {
                          showAlertBox(context, 'Please enter Mobile number',
                              whiteColor, 'Close');
                        } else {
                          if (_formKey.currentState!.validate()) {
                            bool mobileNumberExists =
                                await checkPhoneNumberExistence(
                                    mobileNumberController.text);
                            if (mobileNumberExists) {
                              var result = await phoneAuthentication(
                                  mobileNumberController.text);
                              if (result == null) {
                                // showSnackbar(
                                //     context, 'OTP sent Succesfully', greenColor);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const OTPScreen(),
                                ));
                              } else {
                                showAlertBox(
                                    context, result, whiteColor, 'close');
                              }
                            } else {
                              showAlertBox(
                                  context,
                                  'Enter a valid mobile number',
                                  whiteColor,
                                  'Retry');
                            }
                          } else {
                          }
                        }

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const OTPScreen(),
                        // ));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(PRIMARY_COLOR),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                            color: FONT_COLOR, // Border color
                            width: 1.0, // Border width
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Text(
                          'PROCEED',
                          style: TextStyle(color: FONT_COLOR),
                        ),
                      ),
                    ),
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
