import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sitare/model/astrologer_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<List<AstrologerModel>> fetchAstrologerDetailsFromFirestore() async {
  List<AstrologerModel> astrologersList = [];

  try {
    QuerySnapshot astrologers =
        await firestore.collection('Astrologerdetails').get();

    for (var astrologerDoc in astrologers.docs) {
      Map<String, dynamic> data = astrologerDoc.data() as Map<String, dynamic>;
      AstrologerModel astrologer = AstrologerModel.fromJson(data);
      astrologersList.add(astrologer);
    }
  } catch (e) {
    // Handle errors here
    print("Error fetching astrologer details: $e");
  }

  return astrologersList;
}
