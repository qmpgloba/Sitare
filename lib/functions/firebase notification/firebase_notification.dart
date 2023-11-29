// ignore_for_file: empty_catches, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/main.dart';
import 'package:sitare/model/booking_model.dart';
import 'package:sitare/model/user_model.dart';
import 'package:timezone/timezone.dart' as tz;

class FirebaseNotification {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // await Firebase.initializeApp();
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      saveNotificationToFirestore(notification, message.data);
    }
  }

  Future<void> initNotification() async {
    try {
      await _firebaseMessaging.requestPermission();
      fCMToken = await _firebaseMessaging.getToken();

      if (currentUser != null) {
        String currentFcmToken =
            await fetchFcmToken(currentUser!.uid) as String;
        if (currentFcmToken != fCMToken) {
          Map<String, dynamic>? userData =
              await getUserDataByuid(currentUser!.uid);
          UserModel user = UserModel(
              fcmToken: fCMToken!,
              uid: currentUser!.uid,
              name: userData!['full name'],
              email: userData['email'],
              phoneNumber: userData['phone number'],
              userProfileImage: userData['profile image'],
              gender: userData['gender'],
              dateofBirth: userData['dateofBirth'],
              placeofBirth: userData['placeofBirth'],
              timeofBirth: userData['timeofBirth'],
              maritalStatus: userData['maritalStatus'],
              problem: userData['problem'],
              partnerDetails: userData['partnerDetails'],
              wallet: userData['wallet']);
          // UserModel user = UserModel(
          //     userProfileImage: userData!['profile image'],
          //     fcmToken: fCMToken!,
          //     uid: currentUser!.uid,
          //     name: userData['full name'],
          //     email: userData['email'],
          //     phoneNumber: userData['phone number']);

          await updateUser(user, userData['phone number']);
        }
      }

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          saveNotificationToFirestore(notification, message.data);
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    color: whiteColor,
                    playSound: true,
                    icon: "@mipmap/ic_launcher"),
              ));
        }
      });
    } catch (e) {}
  }

  Future<String?> fetchFcmToken(String userUid) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: userUid)
          .get();
      if (userSnapshot.docs.isNotEmpty) {
        var userData = userSnapshot.docs.first;

        return userData['fcmToken'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

void saveNotificationToFirestore(
    RemoteNotification notification, Map<String, dynamic> data) {
  final firestore = FirebaseFirestore.instance;

  // ignore: duplicate_ignore, duplicate_ignore
  try {
    final notificationData = {
      'title': notification.title,
      'body': notification.body,
      'timestamp': DateTime.now(),
      'uid': currentUser!.uid,
      // 'user_uid': data['uid'],
    };

    firestore
        .collection('user_notifications')
        .add(notificationData)
        .then((_) {})
        .catchError((error) {});
    // ignore: empty_catches
  } catch (e) {}
}

void scheduleCronJob() {
  final cron = Cron();

  const cronExpression = '*/5 * * * *';

  cron.schedule(Schedule.parse(cronExpression), () async {
    // print(DateTime.now());
    await fetchBookedSlotsAndNotify(DateTime.now());
  });
}

Future<void> fetchBookedSlotsAndNotify(DateTime selectedDate) async {
  try {
    List<BookingDetailsModel> availableSlots =
        await getBookedSlots(currentUser!.uid, selectedDate);

    if (availableSlots.isNotEmpty) {
      DateTime now = tz.TZDateTime.now(tz.local);
      for (var slot in availableSlots) {
        List<String> timeComponents = slot.slotBooked.split(':');
        int hours = int.parse(timeComponents[0]);
        int minutes = int.parse(timeComponents[1]);

        DateTime slotTime = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, hours, minutes);

        DateTime notificationTime =
            slotTime.subtract(const Duration(minutes: 10));
        if (now.isAfter(notificationTime) && now.isBefore(slotTime)) {
          Duration difference = slotTime.difference(now);
          int differenceInMinutes = difference.inMinutes;
          await sendNotification('Reminder',
              'Your appointment is in ${differenceInMinutes + 1} minutes!');
        }
      }
    }
  } catch (e) {}
}

Future<void> sendNotification(String title, String body) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(channel.id, channel.name,
          channelDescription: channel.description,
          color: whiteColor,
          playSound: true,
          icon: "@mipmap/ic_launcher");

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
  );
}

Future<List<BookingDetailsModel>> getBookedSlots(
    String currentUserId, DateTime selectedDate) async {
  List<BookingDetailsModel> availableSlots = [];

  try {
    final userCollection = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentUserId)
        .get();

    if (userCollection.docs.isNotEmpty) {
      final userDoc = userCollection.docs.first;
      final docid = userDoc.id;
      final subcollectionRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(docid)
          .collection('bookedSlot')
          .get();

      final formatter = DateFormat('yyyy-MM-dd');
      for (var slot in subcollectionRef.docs) {
        Map<String, dynamic> data = slot.data();
        BookingDetailsModel date = BookingDetailsModel.fromJson(data);
        DateTime dateFromFirestore = date.date;
        String formattedDate = formatter.format(dateFromFirestore);
        String selectedDateString = formatter.format(selectedDate);

        if (formattedDate == selectedDateString) {
          availableSlots.add(date);
        }
      }
    } else {
      throw Exception('uid does not exist');
    }
  } catch (e) {
    // Handle the error appropriately
  }
  // availableSlots.sort((a, b) => a.date.compareTo(b.date));
  return availableSlots;
}
