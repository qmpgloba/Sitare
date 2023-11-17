// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:sitare/functions/details%20functions/details_functions.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/enter%20details%20screen/widgets/details_widget.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({
    super.key,
    required this.phoneNumber,
  });
  final String phoneNumber;

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  int length = 1;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileNumberController;
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pobController = TextEditingController();
  TextEditingController tobController = TextEditingController();
  TextEditingController martialController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? name;
  String? phoneNumber;
  String? email;

  @override
  void initState() {
    setState(() {
      nameController = TextEditingController(text: nameTextController.text);
      mobileNumberController = TextEditingController(text: widget.phoneNumber);
      emailController = TextEditingController(text: emailTextController.text);
      email = emailTextController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                size: size,
                nameController: nameController,
                emailController: emailController,
                mobileNumberController: mobileNumberController,
                dobController: dobController,
                pobController: pobController,
                tobController: tobController,
                problemController: problemController,
                length: length,
                optionalField: optionalField,
                genderController: genderController,
                martialController: martialController,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: onSubmit(
        size: size,
        context: context,
        name: nameController.text,
        email: emailController.text,
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
