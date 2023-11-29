import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/model/booking_model.dart';

class MyBoookingsScreen extends StatelessWidget {
  const MyBoookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<List<BookingDetailsModel>>(
      future: getBookedSlots(currentUser!.uid, DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Data Available'));
        } else {
          List<BookingDetailsModel>? list = snapshot.data;
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              backgroundColor: PRIMARY_COLOR,
              title: const Text(
                'My Bookings',
                style:
                    TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView.builder(
              itemCount: list!.length,
              itemBuilder: (context, index) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Astrologerdetails')
                        .where('uid', isEqualTo: list[index].astrologerId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: SizedBox());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No Data Available'));
                      } else {
                        var docs = snapshot.data!.docs.first;
                        // return Text('${docs['name']}');
                        return Column(
                          children: [
                            
                            Padding(
                              padding: EdgeInsets.all(size.width / 25),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: size.width * .07,
                                      backgroundImage:
                                          NetworkImage(docs['profile image']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            docs['name'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            maxFontSize: 16,
                                            maxLines: 1,
                                          ),
                                          AutoSizeText(
                                            docs['skills'].take(2).join(', '),
                                            // maxLines: 1,
                                            maxFontSize: 12,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          AutoSizeText(
                                              docs['languages'].take(2).join(', '),
                                              // maxLines: 1,
                                              maxFontSize: 12,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                                   Text('${DateFormat('dd MMM yyyy')
                                            .format(list[index].date)} Time: ${list[index].slotBooked}',style: const TextStyle(fontSize: 12,color: greenColor,fontWeight: FontWeight.bold),),
                                        // Text('Time: ${list[index].slotBooked}',style: TextStyle(fontSize: 12),),
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    // Column(
                                    //   children: [
                                       
                                    //   ],
                                    // )
                                  ],
                                ),
                                
                              ),
                            ),
                            const Divider()
                          ],
                          
                        );
                      }
                    });
              },
            ),
          );
        }
      },
    );

    // return Scaffold(
    //   backgroundColor: whiteColor,
    //   appBar: AppBar(
    //     backgroundColor: PRIMARY_COLOR,
    //     title: const Text('My Bookings',style: TextStyle(fontWeight: FontWeight.bold,color: whiteColor),),
    //     centerTitle: true,
    //   ),
    //   body: SafeArea(child: Column(children: [Text('data')],)),
    // );
  }
}

// Future<void> fetchBookedSlotsAndNotify(DateTime selectedDate) async {
//   try {
//     List<BookingDetailsModel> availableSlots =
//         await getBookedSlots(currentUser!.uid, selectedDate);

//     if (availableSlots.isNotEmpty) {
//       DateTime now = tz.TZDateTime.now(tz.local);
//       for (var slot in availableSlots) {
//         List<String> timeComponents = slot.slotBooked.split(':');
//         int hours = int.parse(timeComponents[0]);
//         int minutes = int.parse(timeComponents[1]);

//         DateTime slotTime = DateTime(selectedDate.year, selectedDate.month,
//             selectedDate.day, hours, minutes);

//         DateTime notificationTime =
//             slotTime.subtract(const Duration(minutes: 10));
//         if (now.isAfter(notificationTime) && now.isBefore(slotTime)) {
//           Duration difference = slotTime.difference(now);
//           int differenceInMinutes = difference.inMinutes;
//           // await sendNotification('Reminder',
//           //     'Your appointment is in ${differenceInMinutes + 1} minutes!');
//         }
//       }
//     }
//   } catch (e) {
//   }
// }

// Future<List<BookingDetailsModel>> getBookedSlots(
//     String currentUserId, DateTime selectedDate) async {
//   List<BookingDetailsModel> availableSlots = [];

//   try {
//     final userCollection = await FirebaseFirestore.instance
//         .collection('users')
//         .where('uid', isEqualTo: currentUserId)
//         .get();

//     if (userCollection.docs.isNotEmpty) {
//       final userDoc = userCollection.docs.first;
//       final docid = userDoc.id;
//       final subcollectionRef = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(docid)
//           .collection('bookedSlot')
//           .get();

//       final formatter = DateFormat('yyyy-MM-dd');
//       for (var slot in subcollectionRef.docs) {
//         Map<String, dynamic> data = slot.data();
//         BookingDetailsModel date = BookingDetailsModel.fromJson(data);
//         DateTime dateFromFirestore = date.date;
//         String formattedDate = formatter.format(dateFromFirestore);
//         String selectedDateString = formatter.format(selectedDate);

//         if (formattedDate == selectedDateString) {
//           availableSlots.add(date);
//         }
//       }
//     } else {
//       throw Exception('uid does not exist');
//     }
//   } catch (e) {
//     // Handle the error appropriately
//   }
//   // availableSlots.sort((a, b) => a.date.compareTo(b.date));
//   availableSlots.toSet();
//   return availableSlots;
// }

Future<List<BookingDetailsModel>> getBookedSlots(
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
          // availableSlots.sort((a, b) => a.slotBooked.compareTo(b.slotBooked));
        }
      }

      for (var slot in subcollectionRef.docs) {
        Map<String, dynamic> data = slot.data();
        BookingDetailsModel date = BookingDetailsModel.fromJson(data);
        DateTime dateFromFirestore = date.date;

        // Check if the slot's date and time is in the future
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

  // Sort the available slots by date/time
  availableSlots.sort((a, b) => a.slotBooked.compareTo(b.slotBooked));

  availableSlots.sort((a, b) => a.date.compareTo(b.date));

  return availableSlots;
}
