import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading balance..');
        } else if (snapshot.hasError) {
          return const Text('Error loading balance');
        } else {
          var documents = snapshot.data!.docs;
          if (documents.isNotEmpty) {
            var firstDocument = documents.first;
            dynamic walletValue = firstDocument['wallet'];
            return Text(
              'Available balance: Rs: $walletValue',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
