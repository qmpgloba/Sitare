import 'package:astro_prototype/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widget/customButton.dart';
import '../widget/customTextfield.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            SizedBox(height: 90),
            Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                    color: FONT_COLOR,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 150),
            CustomTextField(
              size: size,
              controller: emailController,
              hintname: "Email",
              validator: _validateEmail,
            ),
            CustomTextField(
              size: size,
              controller: passwordController,
              hintname: "Password",
              obscureText: true,
              validator: _validatePassword,
            ),
            SizedBox(height: 70),
            CustomButtons(
              name: "Login",
              onTap: () {
                if (_key.currentState!.validate()) {
                  print("Doneq");
                } else {
                  Fluttertoast.showToast(
                      msg: "Please enter valid details to login",
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                      color: FONT_COLOR,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 7,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color.fromARGB(201, 122, 116, 116),
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
