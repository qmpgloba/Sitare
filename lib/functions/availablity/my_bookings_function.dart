
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sitare/model/booking_model.dart';

Future<List<BookingDetailsModel>> getBookingDetails(
    String currentUserId, DateTime selectedDate) async {
  List<BookingDetailsModel> availableSlots = [];

  try {
    final userCollection = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentUserId)
        .get();

    if (userCollection.docs.isNotEmpty) {
      final userDoc = userCollection.docs.first;
      final docid = userDoc.id;
      final subcollectionRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(docid)
          .collection('bookedSlot')
          .get();

      final currentTime = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      for (var slot in subcollectionRef.docs) {
        Map<String, dynamic> data = slot.data();
        BookingDetailsModel date = BookingDetailsModel.fromJson(data);
        DateTime dateFromFirestore = date.date;
        String formattedDate = formatter.format(dateFromFirestore);
        String selectedDateString = formatter.format(selectedDate);

        if (formattedDate == selectedDateString) {
          availableSlots.add(date);
        }
      }

      for (var slot in subcollectionRef.docs) {
        Map<String, dynamic> data = slot.data();
        BookingDetailsModel date = BookingDetailsModel.fromJson(data);
        DateTime dateFromFirestore = date.date;

        if (dateFromFirestore.isAfter(currentTime)) {
          availableSlots.add(date);
        }
      }
    } else {
      throw Exception('uid does not exist');
    }
  } catch (e) {
    // Handle the error appropriately
  }

  
  availableSlots.sort((a, b) => a.slotBooked.compareTo(b.slotBooked));

  availableSlots.sort((a, b) => a.date.compareTo(b.date));

  return availableSlots;
}
