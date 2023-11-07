import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sitare/model/availability_slots_model.dart';

Future<List<AvailabilityModel>> getAvailableSlots(String astrologerId) async {
  List<AvailabilityModel> availableSlots = [];
// String number = "+91$phoneNumber";
  try {
    final userColection = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: astrologerId)
        .get();
    // final querySnapShot =
    //     await userColection.where('uid', isEqualTo: astrologerId).limit(1).get();
    if (userColection.docs.isNotEmpty) {
      // Phone number exists in Firestore, store the subcollection
      final userDoc = userColection.docs.first;
      final userUid = userDoc.id;
      final subcollectionRef = await FirebaseFirestore.instance
          .collection('Astrologerdetails')
          .doc(userUid)
          .collection('available slots')
          .get();

           final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      for (var slot in subcollectionRef.docs) {
        Map<String, dynamic> data = slot.data();
        AvailabilityModel date = AvailabilityModel.fromJson(data);
        DateTime dateFromFirestore = date.date;
        String formattedDate = formatter.format(dateFromFirestore);
        String todayDate = formatter.format(now);

        if (dateFromFirestore.isAfter(now) || formattedDate == todayDate) {
          availableSlots.add(date);
        }
      }

      // await subcollectionRef.add(availableSlots.toJson());
    } else {
      // Phone number does not exist in Firestore
      throw Exception('uid does not exist');
    }
  // ignore: empty_catches
  } catch (e) {
  }
  availableSlots.sort((a, b) => a.date.compareTo(b.date));
  return availableSlots;
}
