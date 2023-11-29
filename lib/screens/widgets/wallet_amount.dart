import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';

class WalletAmount extends StatelessWidget {
  const WalletAmount({super.key, required this.color, required this.fontSize});
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          var documents = snapshot.data!.docs;
          if (documents.isNotEmpty) {
            var firstDocument = documents.first;
            dynamic walletValue = firstDocument['wallet'];
            return Text(
              '₹$walletValue',
              style: TextStyle(fontSize: fontSize, color: color),
            );
          } else {
            return const Text(
              'Document does not exist or does not have a "wallet" field',
            );
          }
        }
      },
    );
  }
}
