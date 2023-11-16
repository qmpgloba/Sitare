import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sitare/constants/app_constants.dart';

import 'package:sitare/model/astrologer_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

// Future<List<AstrologerModel>> fetchAstrologerDetailsFromFirestore() async {
//   List<AstrologerModel> astrologersList = [];

//   try {
//     QuerySnapshot astrologers =
//         await firestore.collection('Astrologerdetails').get();

//     for (var astrologerDoc in astrologers.docs) {
//       Map<String, dynamic> data = astrologerDoc.data() as Map<String, dynamic>;

//       AstrologerModel astrologer = AstrologerModel.fromJson(data);
//       astrologersList.add(astrologer);
//     }
//   } catch (e) {

//   }

//   return astrologersList;
// }

Future<List<AstrologerModel>> fetchFilteredAstrologersFromFirestore() async {
  List<AstrologerModel> astrologersList = [];

  try {
    Query astrologersQuery = firestore.collection('Astrologerdetails');

    if (selectedGenders.length == 1) {
      astrologersQuery =
          astrologersQuery.where('gender', whereIn: selectedGenders);
    }

    astrologersQuery = astrologersQuery.where('languages',
        arrayContainsAny: selectedLanguages);
    QuerySnapshot astrologers = await astrologersQuery.get();

    for (var astrologerDoc in astrologers.docs) {
      Map<String, dynamic> data = astrologerDoc.data() as Map<String, dynamic>;

      AstrologerModel astrologer = AstrologerModel.fromJson(data);
      if (selectedSkills.any((skill) => astrologer.skills.contains(skill))) {
        if (selectedExperience.isNotEmpty &&
            selectedExperience.contains(astrologer.experienceYears)) {
          astrologersList.add(astrologer);
        }
      }
    }
  } catch (e) {
    // Handle errors here
  }

  return astrologersList;
}
