import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/onboarding%20page/widgets/onboarding_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<Widget> pages = [
    const OnBoardingPageWidget(
        text: 'Live the life you were born to live.',
        color: redColor,
        isVisible: true),
    const OnBoardingPageWidget(
        text: 'Your path is illuminated by stars. We are here to guide you!',
        color: PRIMARY_COLOR,
        isVisible: false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        rawPages: pages,
        onDone: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const CreateAccountScreen(),
              ),
              (route) => false);
        },
        showBottomPart: true,
        next: const Icon(
          Icons.arrow_forward,
          color: whiteColor,
        ),
        
        done: const Text("Get started", style: TextStyle(color: whiteColor)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: whiteColor,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
