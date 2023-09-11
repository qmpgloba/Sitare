import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class AgreementTextWidget extends StatelessWidget {
  const AgreementTextWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'By Signing up, you agree to our ',
              style: TextStyle(fontSize: size.width * .03)),
          TextSpan(
            text: 'Terms of Use',
            style: TextStyle(
              color: greyColor,
              decoration: TextDecoration.underline,
              fontSize: size.width * .03,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const HomeScreen(),
                // ));
              },
          ),
          TextSpan(text: ' & ', style: TextStyle(fontSize: size.width * .03)),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: greyColor,
              decoration: TextDecoration.underline,
              fontSize: size.width * .03,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
