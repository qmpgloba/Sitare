import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/profile%20screen/widgets/astroleger_profile_details_widget.dart';
import 'package:sitare/screens/profile%20screen/widgets/contact_icons_widget.dart';

import 'widgets/next_availability_widget.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  num walletBalnce = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: whiteColor),
          backgroundColor: PRIMARY_COLOR,
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
          ),
          actions: [
            ElevatedButton.icon(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: MaterialStatePropertyAll(PRIMARY_COLOR),
                    elevation: MaterialStatePropertyAll(0)),
                onPressed: () {},
                icon: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: greyColor,
                ),
                label: Text(
                  '₹$walletBalnce',
                  style: const TextStyle(fontSize: 18, color: greyColor),
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                  color: greyColor,
                ))
          ],
        ),
        
        body: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.width * .5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://shreepng.com/img/OutSide/Celebrities/SmritiMandhana/Smriti%20Mandhana.png',
                        ),
                        fit: BoxFit.contain)),
              ),
              AstrologerProfileDetailsWidget(
                  size: size,
                  name: 'Smrithi Mandhana',
                  department: 'Tarot,Numerology',
                  languages: 'English,Hindi,Punjabi',
                  rating: 5,
                  yearsOfExperience: 15,
                  rupees: 95),
              const Column(
                children: [
                  TabBar(
                      indicatorColor: redColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: 'About',
                        ),
                        Tab(
                          text: 'Articles',
                        ),
                        Tab(
                          text: 'Reviews',
                        ),
                      ]),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(size.width / 16),
                  child: const TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Center(
                            child: Text(
                          """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                        """,
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Center(child: Text('data')),
                      Center(child: Text('data')),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.width * .14,
                    child: Row(
                      children: [
                        Container(
                          height: double.maxFinite,
                          width: size.width * .55,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Center(
                              child: AutoSizeText(
                            'TALK TO SMRITHI MANDHANA NOW',
                            maxLines: 1,
                            minFontSize: 8,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        Expanded(
                          child: Container(
                            height: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ContactIconWidgetWithText(
                                      icon: Icons.chat_outlined,
                                      text: 'Chat'),
                                  ContactIconWidgetWithText(
                                      icon: Icons.call_outlined,
                                      text: 'Call'),
                                  ContactIconWidgetWithText(
                                      icon: Icons.video_call_outlined,
                                      text: 'Video')
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width / 20,
                  ),
                  NextAvailabilityWidget(size: size),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
