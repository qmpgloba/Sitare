import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/widget/custom_button.dart';
import 'package:sitare/widget/custom_textfield.dart';


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
        child: Padding(
          padding:  EdgeInsets.all(size.width/16
          ),
          child: Column(
            children: [
              const SizedBox(height: 90),
              const Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      color: FONT_COLOR,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 150),
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
              const SizedBox(height: 70),
              CustomButtons(
                name: "Login",
                onTap: () {
                  if (_key.currentState!.validate()) {
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please enter valid details to login",
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: FONT_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountScreen(),));
                    },
                    child: const Text(
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
      ),
    ));
  }
}
