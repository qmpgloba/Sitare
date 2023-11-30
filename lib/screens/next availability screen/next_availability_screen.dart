import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/availablity/available_time_slots_function.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/next%20availability%20screen/widgets/tab_widget.dart';
import 'package:sitare/screens/next%20availability%20screen/widgets/time_slots_widget.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/model/availability_slots_model.dart';
import 'package:sitare/screens/widgets/show_dialog_widget.dart';
import 'package:sitare/screens/widgets/show_toast.dart';

import 'widgets/profile_details_widget.dart';

class NextAvailabilityScreen extends StatefulWidget {
  const NextAvailabilityScreen({super.key, required this.astrologer});
  final AstrologerModel astrologer;

  @override
  State<NextAvailabilityScreen> createState() => _NextAvailabilityScreenState();
}

class _NextAvailabilityScreenState extends State<NextAvailabilityScreen>
    with TickerProviderStateMixin {
  var time = ['8:30', '9:30', '10:30', '12:30', '3:00', '4:00', '5:00'];
  late TabController _tabController;
  int? selected;
  List slots = [];
  List availableSlots = [];
  List selectedSlots = [];
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<List<AvailabilityModel>>(
      future: getAvailableSlots(widget.astrologer.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          slots = snapshot.data!;
          _tabController = TabController(length: slots.length, vsync: this);
          // availableSlots = slots['available slots'];

          return DefaultTabController(
            length: slots.length,
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                backgroundColor: PRIMARY_COLOR,
                title: const Text(
                  'Next Availability',
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Column(
                children: [
                  ProfileWidgetNextAvailabilityScreen(
                      size: size, astrologer: widget.astrologer),
                  slots.isEmpty
                      ? const SizedBox()
                      : Container(
                          height: size.width / 5,
                          color: const Color.fromARGB(255, 3, 11, 59),
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.all(size.width * .03),
                            child: TabBar(
                              controller: _tabController,
                              dividerColor: Colors.transparent,
                              isScrollable: true,
                              physics: const BouncingScrollPhysics(),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.cyan,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding:
                                  const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: whiteColor),
                              // tabs: [
                              //   Text(slots[1].date.toString())
                              // ],
                              tabs: slots.map((date) {
                                return TabWidget(dateTime: date.date);
                              }).toList(),
                            ),
                          ),
                        ),
                  Expanded(
                    child: slots.isEmpty
                        ? const Center(
                            child: Text('Astrologer unavailable'),
                          )
                        : TabBarView(
                            controller: _tabController,
                            physics: const BouncingScrollPhysics(),
                            children: slots.map((date) {
                              List availableSlotsForDate = List.from(date
                                  .availableSlots); // Create a new list for each date
                              availableSlotsForDate.sort();
                              List bookedSlotsForDate =
                                  List.from(date.bookedSlots);
                              bookedSlotsForDate.sort();
                              return TimeSlotsWidget(
                                timeSlots: availableSlotsForDate,
                                bookedSlots: bookedSlotsForDate,
                                dateTime: date.date,
                                selected: selected,
                                onSelectionChanged: (value) {
                                  // setState(() {
                                  currentIndex = _tabController.index;
                                  selected = value;
                                  // });
                                },
                              );
                            }).toList(),
                          ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      slots[_tabController.index].availableSlots.sort();
                      if (currentIndex == _tabController.index &&
                          selected != null) {
                        List booked = slots[_tabController.index].bookedSlots;
                        booked.add(slots[_tabController.index]
                            .availableSlots[selected]);
                        AvailabilityModel bookedSlot = AvailabilityModel(
                            date: slots[_tabController.index].date,
                            availableSlots:
                                slots[_tabController.index].availableSlots,
                            bookedSlots: booked);
                        await updateAvailableSlotsInFireBase(
                                userData!['uid'],
                                slots[_tabController.index].date,
                                bookedSlot,
                                widget.astrologer.uid,
                                slots[_tabController.index]
                                    .availableSlots[selected])
                            .then((value) {
                          showToast('Slot Booked Successfully', greenColor);
                          Navigator.of(context).pop();
                        });
                      } else {
                        showAlertBox(
                          context,
                          'Please select time slot',
                          whiteColor,
                          'ok',
                        );
                      }
                      // print(slots[_tabController.index].date);
                      // print(slots[_tabController.index].availableSlots[selected]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        // height: 30,
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: Center(
                            child: AutoSizeText(
                              'BOOK NOW',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const Expanded(child: SizedBox())
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
