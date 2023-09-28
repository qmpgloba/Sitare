
import 'package:flutter/material.dart';
import 'package:sitare/screens/create%20account%20page/functions/functions.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/onboarding%20page/onboarding_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User?>();

    if(currentUser != null){
      return const HomeScreen();
    }else{
      return    OnBoardingScreen();
    }
  }
}

