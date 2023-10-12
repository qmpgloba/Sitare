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
      // astrologersList.add(astrologer);
     if (selectedSkills.any((skill) => astrologer.skills.contains(skill))) {
     if (selectedExperience.isNotEmpty && selectedExperience.contains(astrologer.experienceYears)) {
          astrologersList.add(astrologer);
        }
  }
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



// List<AstrologerModel> searchFirestoreCollection(
//     TextEditingController controller,List<AstrologerModel> filteredAstrologers,List<AstrologerModel> astrologers)  {
//        List<AstrologerModel> astrologersList = [];
//     filteredAstrologers = astrologers
//             .where((astrologer) =>
//                 astrologer.fullName.toLowerCase().contains(controller.text.toLowerCase()))
//             .toList();
//    return astrologersList;
// }