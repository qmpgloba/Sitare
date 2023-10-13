import 'package:cloud_firestore/cloud_firestore.dart';
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



updateUser(UserModel user, String email) async {
  final db = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot =
        await db.collection('users').where('email', isEqualTo: email).get();

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

