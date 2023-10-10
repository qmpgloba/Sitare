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
//     // Handle errors here
//   }

//   return astrologersList;
// }

Future<List<AstrologerModel>> fetchFilteredAstrologersFromFirestore() async {
  List<AstrologerModel> astrologersList = [];

  try {
    Query astrologersQuery = firestore.collection('Astrologerdetails');

    // Apply filters if selectedGender is not null
    // if (selectedGenders.isNotEmpty) {
    //   astrologersQuery = astrologersQuery.where('gender', arrayContainsAny: selectedGenders);
    // }

    // Apply filters if selectedLanguages is not empty

    
    if (selectedGenders.length == 1) {
      astrologersQuery = astrologersQuery.where('gender', whereIn: selectedGenders);
    }
// if (selectedSkills.isNotEmpty) {
//   astrologersQuery = astrologersQuery.where('skills', arrayContainsAny: selectedSkills);
// }
// if (selectedExperience.isNotEmpty) {
//   astrologersQuery = astrologersQuery.where('experience(in years)', arrayContainsAny: (selectedExperience));
// }
// if (selectedLanguages.isNotEmpty) {
//   astrologersQuery = astrologersQuery.where('languages', arrayContainsAny: selectedLanguages);
// }

    // astrologersQuery = astrologersQuery.where('skills', arrayContainsAny: selectedSkills);
    // astrologersQuery = astrologersQuery.where('languages',
    //     arrayContainsAny: selectedLanguages,);
      
   
    
    QuerySnapshot astrologers = await astrologersQuery.get();

    for (var astrologerDoc in astrologers.docs) {
      Map<String, dynamic> data = astrologerDoc.data() as Map<String, dynamic>;
      print(data);

      AstrologerModel astrologer = AstrologerModel.fromJson(data);
      astrologersList.add(astrologer);
    }
  } catch (e) {
    // Handle errors here
  }

  return astrologersList;
}

// Stream<List<AstrologerModel>> streamFilteredAstrologersFromFirestore() {
//   try {
//     Query astrologersQuery = firestore.collection('Astrologerdetails');

//     if (selectedGenders.isNotEmpty) {
//       astrologersQuery = astrologersQuery.where('gender', whereIn: selectedGenders);
//     }

//     return astrologersQuery.snapshots().map((querySnapshot) {
//       List<AstrologerModel> astrologersList = [];

//       for (var astrologerDoc in querySnapshot.docs) {
//         Map<String, dynamic> data = astrologerDoc.data() as Map<String, dynamic>;
//         AstrologerModel astrologer = AstrologerModel.fromJson(data);
//         astrologersList.add(astrologer);
//       }

//       return astrologersList;
//     });
//   } catch (e) {
//     // Handle errors here
//     return Stream.error(e);
//   }
// }

// Future<QuerySnapshot> fetchFilteredData() async {
//     var query = FirebaseFirestore.instance.collection('users');

//     if (genderOptions.isNotEmpty) {
//       query = query.where('gender', isEqualTo: genderOptions);
//     }

//     if (selectedLanguages.isNotEmpty) {
//       query = query.where('languages', arrayContainsAny: selectedLanguages);
//     }

//     return await query.get();
//   }
