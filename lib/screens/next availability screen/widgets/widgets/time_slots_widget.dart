
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sitare/constants/ui_constants.dart';

// class TimeSlotsWidget extends StatefulWidget {
//    TimeSlotsWidget({
//     super.key,
  
//     required this.dateTime, required this.timeSlots, 
//   });

//   // final List selectedIndex;
//   // final List selected;
//   final Timestamp dateTime;
//   final List timeSlots;
//   int? selected;
  

//   @override
//   State<TimeSlotsWidget> createState() => _TimeSlotsWidgetState();
// }

// class _TimeSlotsWidgetState extends State<TimeSlotsWidget> {
  
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: GridView.builder(
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10),
//         itemCount: widget.timeSlots.length,
//         itemBuilder: (context, index) { 
//           return GestureDetector(
//             onTap: () {
//               // if (widget.selectedIndex.contains(index)) {
//               //   widget.selected.remove(widget.timeSlots[index]);
//               //   widget.selectedIndex.remove(index);
//               // } else {
//               //   widget.selected.add(widget.timeSlots[index]);
//               //   widget.selectedIndex.add(index);
//               // }
//               widget.selected = index;
//               print(widget.selected);
//               print(index);
//               setState(() {});
//             },
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
//               child: Container(
//                 // width: 30,
//                 height: 5,

//                 decoration: BoxDecoration(
//                   color: widget.selected == index
//                       ? blackColor
//                       : whiteColor,
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Center(
//                   child: Text(
//                     widget.timeSlots[index],
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: widget.selected == index
//                             ? whiteColor
//                             : Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
