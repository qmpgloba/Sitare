import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/model/user_model.dart';

Future<DocumentSnapshot<Map<String, dynamic>>?> getUserDataByPhoneNumber(
    String phoneNumber) async {
// String number = "+91$phoneNumber";
  final userColection = FirebaseFirestore.instance.collection('users');
  final querySnapShot = await userColection
      .where('phone number', isEqualTo: phoneNumber)
      .limit(1)
      .get();
  if (querySnapShot.docs.isNotEmpty) {
    return querySnapShot.docs.first;
  } else {
    return null;
  }
}

// Future<bool> checkPhoneNumberExistence(String mobileNumber) async {
//   final phoneNumber = mobileNumber;

//   try {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('phone number', isEqualTo: phoneNumber)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       // Phone number exists in Firestore
//       return true;
//     } else {
//       // Phone number does not exist in Firestore
//       return false;
//     }
//     // ignore: unused_catch_clause
//   } on FirebaseException catch (e) {
//     return false;
//   }
// }

Future<String> addProfileImge(XFile imagePicked) async {
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('user_profile_images');

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

  try {
    await referenceImageToUpload.putFile(File(imagePicked.path));
    String imageUrl = await referenceImageToUpload.getDownloadURL();
    return imageUrl;
  } catch (e) {
    return profileImage;
  }
}

createUser(UserModel user) async {
  final db = FirebaseFirestore.instance;

  try {
    await db.collection('users').add(
          user.toJson(),
        );
    return true;
    // ignore: empty_catches, unused_catch_clause
  } on FirebaseException catch (e) {
    return false;
  }
}

updateUser(UserModel user, String phoneNumber) async {
  final db = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot = await db
        .collection('users')
        .where('phone number', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      await documentSnapshot.reference.update(user.toJson());
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
