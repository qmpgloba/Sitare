import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/next%20availability%20screen/next_availability_screen.dart';
import 'package:sitare/screens/order%20history%20screen/order_history_screen.dart';
import 'package:sitare/screens/profile%20screen/profile_screen.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/talk_to_experts_screen.dart';

import 'constants/ui_constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: PRIMARY_COLOR,
       
        useMaterial3: true,
      ),
      home: ProfileScreen(),
    );
  }
}