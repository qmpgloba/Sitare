import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
User? get currentUser => _auth.currentUser;
Stream<User?> get authState => _auth.authStateChanges();
Future<String?> signUpWithEmail({
  required String email,
  required String password,
}) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null;
  } on FirebaseAuthException catch (e) {
    return e.message.toString();
  }
}

String? validateEmail(String? value) {
  if (value!.isNotEmpty &&
      !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(value)) {
    return 'Enter valid Email';
  } else {
    return null;
  }
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your name';
  } else {
    return null;
  }
}

String? validateConfirmPassword(String? value, String? password) {
  if (value!.isEmpty) {
    return 'Please enter your password';
  } else if (value.length < 6 && value.isNotEmpty) {
    return 'Minimum 6 characters required';
  } else if (value != password) {
    return 'Please enter same password';
  } else {
    return null;
  }
}
