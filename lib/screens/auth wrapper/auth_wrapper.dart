
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare/screens/onboarding%20page/onboarding_screen.dart';
import 'package:sitare/screens/shopping%20cart/cart.dart';

class AuthWrapper extends StatelessWidget {
   AuthWrapper({super.key});
   final user = FirebaseAuth.instance.currentUser;
   

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User?>();

    if(user != null){
      return const ShoppingCart();
    }else{
      return    OnBoardingScreen();
    }
  }
}

