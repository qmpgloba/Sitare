import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/main.dart';
import 'package:sitare/model/user_model.dart';

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
     fCMToken = await _firebaseMessaging.getToken();
    print('token: $fCMToken');

    if (currentUser != null) {
      String currentFcmToken = await fetchFcmToken(currentUser!.uid) as String;
      if (currentFcmToken != fCMToken) {
        Map<String, dynamic>? userData =
            await getUserDataByuid(currentUser!.uid);

        UserModel user = UserModel(
            userProfileImage: userData!['profile image'],
            fcmToken: fCMToken!,
            uid: currentUser!.uid,
            name: userData['full name'],
            email: userData['email'],
            phoneNumber: userData['phone number']);

            await updateUser(user, userData['phone number']);
      }
    }

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackGroundHandler);

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
