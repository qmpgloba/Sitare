import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String,dynamic>>?> getUserDataByEmail (String email) async{

// String number = "+91$phoneNumber";
  final userColection = FirebaseFirestore.instance.collection('users');
  final querySnapShot = await userColection.where('email',isEqualTo: email).limit(1).get();
  if(querySnapShot.docs.isNotEmpty){
    return querySnapShot.docs.first;
  }else{
    return null;
  }

  


}