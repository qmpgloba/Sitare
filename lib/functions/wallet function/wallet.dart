// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

updateWallet(String userId, double amount) async {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  final db = FirebaseFirestore.instance;

  try {
    QuerySnapshot snapshot =
        await db.collection('users').where('uid', isEqualTo: userId).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = snapshot.docs.first;
      await documentSnapshot.reference.update({'wallet': amount.toString()});
      print('Wallet updated');
    } else {
      print('User document does not exist');
    }
  } catch (e) {
    print('Error updating wallet: $e');
  }
}
