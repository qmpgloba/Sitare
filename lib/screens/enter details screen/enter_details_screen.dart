// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/functions/details%20functions/details_functions.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/details_widget.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({
    super.key,
    required this.phoneNumber,
    required this.name,
    required this.email,
  });
  final String phoneNumber;
  final String name;
  final String email;
  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  int length = 1;

  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pobController = TextEditingController();
  TextEditingController tobController = TextEditingController();
  TextEditingController martialController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  final _key = GlobalKey<FormState>();
  // String? name;
  // String? phoneNumber;
  // String? email;

  @override
  Widget build(BuildContext context) {
    print(currentUser!.uid);
    Size size = MediaQuery.sizeOf(context);
    // if (currentUser != null) {
    //   setState(() {
    //     name = currentUser!.displayName;
    //     email = currentUser!.email;
    //   });
    // }
    // nameController = TextEditingController(text: name ?? '');
    // mobileNumberController = TextEditingController(text: widget.phoneNumber);
    // emailController = TextEditingController(text: email ?? '');
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                top: size.height * 0.02,
                bottom: size.height * 0.01,
              ),
              child: DetailsWidget(
                size: size, name: widget.name, email: widget.email,
                mobileNumber: widget.phoneNumber,
                // nameController: widget.name,
                // emailController: widget.email,
                // mobileNumberController: widget.phoneNumber,
                dobController: dobController,
                pobController: pobController,
                tobController: tobController,
                problemController: problemController,
                optionalField: optionalField,
                genderController: genderController,
                martialController: martialController,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: onSubmit(
        key: _key,
        size: size,
        context: context,
        name: widget.name,
        email: widget.email,
        mobile: phoneNumberTextController.text,
        gender: genderController.text,
        dob: dobController.text,
        pob: pobController.text,
        tob: tobController.text,
        maritalStatus: martialController.text,
        problem: problemController.text,
      ),
    );
  }
}
