import 'package:astro_prototype/screens/home_screen.dart';
import 'package:astro_prototype/screens/login_email_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/ui_constants.dart';
import 'screens/filter_section_screen.dart';
import 'screens/enter_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: PRIMARY_COLOR,
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
