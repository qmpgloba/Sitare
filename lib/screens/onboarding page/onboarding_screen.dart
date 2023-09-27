
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sitare/constants/ui_constants.dart';

class OnboardingScreen extends StatelessWidget {
  final List<Widget> pages = [
    SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: \,
          children: [
            SizedBox(height: 30,),
            Text('SITARE',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            
            Expanded(child: Container(child: Center(child: Text('Live the life you were born to live.',style: TextStyle(fontSize: 30),))))
          ],
        ),
      ),
    ),
     SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: \,
          children: [
            SizedBox(height: 30,),
            Text('SITARE',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            
            Expanded(child: Container(child: Center(child: Text('Live the life you were born to live.',style: TextStyle(fontSize: 30),))))
          ],
        ),
      ),
    ),
     SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: \,
          children: [
            SizedBox(height: 30,),
            Text('SITARE',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            
            Expanded(child: Container(child: Center(child: Text('Live the life you were born to live.',style: TextStyle(fontSize: 30),))))
          ],
        ),
      ),
    ),
    // PageViewModel(
    //   title: "Easy to Use",
    //   body: "Simple and intuitive interface.",
    //   image: Image.asset("assets/onboarding2.png"),
    // ),
    // PageViewModel(
    //   title: "Get Started",
    //   body: "Start using the app now!",
    //   image: Image.asset("assets/onboarding3.png"),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          rawPages: pages,
          onDone: () {
            // Handle the "Done" button press (e.g., navigate to the main screen)
          },
          onSkip: () {
            // Handle the "Skip" button press (e.g., navigate to the main screen)
          },
          showSkipButton: true,
          skip: const Text("Skip",style: TextStyle(color: blackColor),),
          next: const Icon(Icons.arrow_forward,color: blackColor,),
          done: const Text("Done",style: TextStyle(color: blackColor)),
          dotsDecorator: DotsDecorator(
            size: Size(10.0, 10.0),
            color: blackColor,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}