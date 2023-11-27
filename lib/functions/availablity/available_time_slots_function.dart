import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/model/availability_slots_model.dart';
import 'package:sitare/model/booking_model.dart';

Future<List<AvailabilityModel>> getAvailableSlots(String astrologerId) async {
  List<AvailabilityModel> availableSlots = [];

  try {
    final userColection = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: astrologerId)
        .get();

    if (userColection.docs.isNotEmpty) {
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
    } else {
      throw Exception('uid does not exist');
    }
    // ignore: empty_catches
  } catch (e) {}
  availableSlots.sort((a, b) => a.date.compareTo(b.date));
  return availableSlots;
}

Future<void> updateAvailableSlotsInFireBase(String uid, DateTime date,
    AvailabilityModel availableSlots, String astrologerId) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
    
      final userDoc = querySnapshot.docs.first;
      final userUid = userDoc.id;
      final subcollectionRef = FirebaseFirestore.instance
          .collection('Astrologerdetails')
          .doc(userUid)
          .collection('available slots');

      
      final query = await subcollectionRef.where('date', isEqualTo: date).get();
      if (query.docs.isNotEmpty) {
        final docId = query.docs.first.id;
        await subcollectionRef.doc(docId).update(availableSlots.toJson());
        final subcollectionRef2 = FirebaseFirestore.instance
            .collection('Astrologerdetails')
            .doc(userUid)
            .collection('available slots')
            .doc(docId)
            .collection('booked details');
        BookingDetailsModel slotBooked = BookingDetailsModel(

          userUid: currentUser!.uid,
          astrologerId: astrologerId,
          slotBooked: availableSlots.bookedSlots.first,
        );


        await subcollectionRef2.add(slotBooked.toJson());
      } else {
        throw Exception('Document not found for the given date');
      }
    } else {
     
      throw Exception('uid does not exist');
    }
  } on FirebaseException catch (e) {
    throw Exception('Error accessing Firestore: $e');
  }
}
