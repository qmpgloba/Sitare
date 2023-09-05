import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

import 'widgets/profile_details_widget.dart';
import 'widgets/tab_widget.dart';

class NextAvailabilityScreen extends StatefulWidget {
  NextAvailabilityScreen({super.key});

  @override
  State<NextAvailabilityScreen> createState() => _NextAvailabilityScreenState();
}

class _NextAvailabilityScreenState extends State<NextAvailabilityScreen> {
  var time = ['8:30', '9:30', '10:30', '12:30', '3:00', '4:00', '5:00'];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: const Text(
            'Next Availability',
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            ProfileWidgetNextAvailabilityScreen(size: size),
            Container(
              height: size.width / 5,
              color: const Color.fromARGB(255, 3, 11, 59),
              width: size.width,
              child: Padding(
                padding: EdgeInsets.all(size.width * .03),
                child: TabBar(

                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.cyan,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  tabs: const [
                    TabWidget(),
                   TabWidget(),
                   TabWidget(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemCount: time.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selected = index;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                            child: Container(
                              // width: 30,
                              height: 5,
                  
                              decoration: BoxDecoration(
                                color: index == selected
                                    ? PRIMARY_COLOR
                                    : whiteColor,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  time[index],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: selected == index
                                          ? whiteColor
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text('data'),
                  Text('data'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.maxFinite,
                  // height: 30,
                  decoration: BoxDecoration(
                      color: redColor, borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: AutoSizeText(
                        'BOOK NOW',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
