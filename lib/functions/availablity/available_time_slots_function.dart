import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sitare/model/availability_slots_model.dart';

Future<List<AvailabilityModel>> getAvailableSlots(String astrologerId) async {
  List<AvailabilityModel> availableSlots = [];
  print(astrologerId);
// String number = "+91$phoneNumber";
  try {
    final userColection = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: astrologerId)
        .get();
    // final querySnapShot =
    //     await userColection.where('uid', isEqualTo: astrologerId).limit(1).get();
    print(userColection.docs.first);
    if (userColection.docs.isNotEmpty) {
      print('object');
      // Phone number exists in Firestore, store the subcollection
      final userDoc = userColection.docs.first;
      print(userDoc.data());
      final userUid = userDoc.id;
      print(userUid);
      final subcollectionRef = await FirebaseFirestore.instance
          .collection('Astrologerdetails')
          .doc(userUid)
          .collection('available slots')
          .get();

           final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      subcollectionRef.docs.forEach((slot) {
        Map<String, dynamic> data = slot.data() as Map<String, dynamic>;
        print(data);
        AvailabilityModel date = AvailabilityModel.fromJson(data);
        DateTime dateFromFirestore = date.date;
        String formattedDate = formatter.format(dateFromFirestore);
        String todayDate = formatter.format(now);

        if (dateFromFirestore.isAfter(now) || formattedDate == todayDate) {
          availableSlots.add(date);
        }
      });

      // await subcollectionRef.add(availableSlots.toJson());
    } else {
      // Phone number does not exist in Firestore
      throw Exception('uid does not exist');
    }
  } catch (e) {
    print(e.toString());
  }
  print(availableSlots);
  availableSlots.sort((a, b) => a.date.compareTo(b.date));
  return availableSlots;
}
