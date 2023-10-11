import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sitare/screens/auth%20wrapper/auth_wrapper.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/talk_to_experts_screen.dart';

import 'constants/ui_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: PRIMARY_COLOR,
          fontFamily: 'Muli',
          useMaterial3: true,
        ),
        home:  TalkToExpertsScreen());
  }
}
