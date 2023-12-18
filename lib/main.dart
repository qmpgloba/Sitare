import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sitare/functions/firebase%20notification/firebase_notification.dart';
import 'package:sitare/screens/auth%20wrapper/auth_wrapper.dart';
import 'package:sitare/screens/shopping%20cart/cart.dart';
import 'constants/ui_constants.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'High Important channel'
      'High Important Notification',
  "This channel is used for important notification.",
  importance: Importance.high,
  playSound: true, 
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PackageInfo.fromPlatform();
  await Firebase.initializeApp();
  await FirebaseNotification().initNotification();
  tzdata.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  scheduleCronJob();
  runApp(const MyApp());
}

String? fCMToken;

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
      home: FutureBuilder(
        future: fetchBookedSlotsAndNotify(DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ShoppingCart();
          }
        },
      ),
    );
  }
}
