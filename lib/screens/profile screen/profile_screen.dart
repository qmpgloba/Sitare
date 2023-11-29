import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/contact%20functions/contact_functions.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/chat_screen.dart';
import 'package:sitare/screens/profile%20screen/widgets/astroleger_profile_details_widget.dart';
import 'package:sitare/screens/profile%20screen/widgets/contact_icons_widget.dart';
import 'widgets/next_availability_widget.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.astrologer});

  final AstrologerModel astrologer;

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
                elevation: MaterialStatePropertyAll(0),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.account_balance_wallet_outlined,
                color: greyColor,
              ),
              label: Text(
                '₹$walletBalnce',
                style: const TextStyle(fontSize: 18, color: greyColor),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share_outlined,
                color: greyColor,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.width * .5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      astrologer.profilePic,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              AstrologerProfileDetailsWidget(
                size: size,
                name: astrologer.fullName,
                department: "${astrologer.skills.take(2).join(',')}...",
                languages: "${astrologer.languages.take(2).join(',')}...",
                rating: 5,
                yearsOfExperience: astrologer.experienceYears.toString(),
                rupees: 95,
                astrologer: astrologer,
              ),
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
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(size.width / 16),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: Text(
                            astrologer.description,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Center(child: Text('data')),
                      const Center(child: Text('data')),
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
                          child: Center(
                            child: AutoSizeText(
                              'TALK TO ${astrologer.fullName.toUpperCase()} NOW',
                              maxLines: 1,
                              minFontSize: 8,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: double.maxFinite,
                            decoration: const BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ChatScreen(astrologer: astrologer),
                                      ));
                                    },
                                    child: const ContactIconWidgetWithText(
                                      icon: Icons.chat_outlined,
                                      text: 'Chat',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      sendCallNotification(astrologer.fcmToken);
                                    },
                                    child: const ContactIconWidgetWithText(
                                      icon: Icons.call_outlined,
                                      text: 'Call',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchWhatsAppUri(astrologer.phoneNumber);
                                    },
                                    child: const ContactIconWidgetWithText(
                                      icon: Icons.video_call_outlined,
                                      text: 'Video',
                                    ),
                                  ),
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
                  NextAvailabilityWidget(size: size, astrologer: astrologer),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
