import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
String verifyId = '';

Future<String?> phoneAuthentication(String number) async {
  try {
    print(number);
    await _auth.verifyPhoneNumber(
      
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (error) {
        // showSnackBar(context, Colors.red, error.message.toString());
      },
      codeSent: (verificationId, forceResendingToken) {
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    return null;
  } on FirebaseAuthException catch (e) {
    return e.message.toString();
    // showSnackBar(context, themeColor, e.message.toString());
  }
}

Future<bool> verifyOTP(String otp) async {
  var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp));

  return credentials.user != null ? true : false;
}

Future<bool> checkPhoneNumberExistence(String mobileNumber) async {
  final phoneNumber = mobileNumber;

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phone number', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Phone number exists in Firestore
      return true;
    } else {
      // Phone number does not exist in Firestore
      return false;
    }
    // ignore: unused_catch_clause
  } on FirebaseException catch (e) {
    return false;
  }
}
