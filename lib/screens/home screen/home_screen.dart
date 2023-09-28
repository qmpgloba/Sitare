import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/get_user_details.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/home%20screen/widgets/list_items_drawer.dart';
import 'package:sitare/screens/home%20screen/widgets/user_details_drawer_header.dart';
import 'package:sitare/screens/login%20email%20screen/login_email_screen.dart';
import 'package:sitare/screens/order%20history%20screen/order_history_screen.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/talk_to_experts_screen.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';
import 'package:sitare/screens/welcome%20page/welcome_screen.dart';
import 'package:sitare/widget/buynow_homescreen_widget.dart';
import 'package:sitare/widget/connect_with_experts_widget.dart';
import 'package:sitare/widget/get_detail_report_widget.dart';
import 'package:sitare/widget/icon_widget.dart';
import 'package:sitare/widget/live_text_widget_carousel.dart';
import 'package:sitare/widget/profile_widget_carousel.dart';
import 'package:sitare/widget/shop_sitare_container_widget.dart';

Map<String, dynamic>? userData;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<String> sliderOptions = [
  'DAILY HOROSCOPE',
  'STUDY ASTROLOGY',
  'HOROSCOPE MATCHING',
  'ASTROLOGY MATCHING',
  'RELATIONSHIP STATUS',
  'MATRIMONIAL MATCHING',
];

class _HomeScreenState extends State<HomeScreen> {
  final int containerCount = 5;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < sliderOptions.length - 1) {
        _currentIndex++;
        _scrollController.animateTo(
          _currentIndex * 135.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        _currentIndex = 0;
        _scrollController.animateTo(
          _currentIndex * 135.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String mobile = (FirebaseAuth.instance.currentUser!.phoneNumber!)??("+91"+phoneNumberTextController.text);
    print(mobile);
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<DocumentSnapshot?>(
        future:
            getUserDataByEmail(mobile),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            userData = snapshot.data!.data() as Map<String, dynamic>;
            //  documentID = snapshot.data!.id;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: PRIMARY_COLOR,
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  'SITARE',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
                ),
                actions: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: greyColor,
                    ),
                    label: const Text(
                      '₹0',
                      style: TextStyle(fontSize: 18, color: greyColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // width: size.width*.7,
                      child: UserDetailsDrawerHeader(
                          size: size,
                          fullName: userData!['full name'],
                          email: userData!['email'],
                          phoneNumber: userData!['phone number']),
                    ),
                    const ListItemsDrawer(
                        icon: Icons.home_outlined, text: 'Home'),
                    const Divider(),
                    ListTile(
                      leading:
                          const Icon(Icons.account_balance_wallet_outlined),
                      title: const AutoSizeText(
                        'Wallet',
                        maxLines: 1,
                      ),
                      trailing: Wrap(
                        spacing: 5,
                        children: [
                          const AutoSizeText(
                            '₹200.00',
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WalletRechargeScreen(),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                child: AutoSizeText(
                                  'RECHARGE',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderHistoryScreen(),
                          ));
                        },
                        child: const ListItemsDrawer(
                            icon: Icons.list, text: 'Order History')),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        dynamic conversationObject = {
                          'appId': '92f796d009e254c06686a249bd1b465b',
                        };
                        KommunicateFlutterPlugin.buildConversation(
                                conversationObject)
                            .then((clientConversationId) {
                          print("Conversation builder success : " +
                              clientConversationId.toString());
                        }).catchError((error) {
                          print("Conversation builder error : " +
                              error.toString());
                        });
                      },
                      child: const ListItemsDrawer(
                          icon: Icons.wechat_outlined,
                          text: 'Customer Support'),
                    ),
                    const Divider(),
                    const ListItemsDrawer(
                        icon: Icons.settings_outlined, text: 'Settings'),
                    const Divider(),
                    const ListItemsDrawer(
                        icon: Icons.share_outlined, text: 'Share'),
                    GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                                (route) => false);
                          });
                        },
                        child: const ListItemsDrawer(
                            icon: Icons.logout, text: 'Logout')),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.all(size.width / 16),
                      child: const Text('Version 1.0'),
                    ),
                  ],
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width / 15),
                    child: const Text(
                      "Hi Guru, Welcome",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: sliderOptions.length * 2,
                      itemBuilder: (context, index) {
                        final adjustedIndex = index % sliderOptions.length;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          width: 135,
                          child: ListTile(
                            title: Center(
                              child: Text(
                                sliderOptions[adjustedIndex],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 8, 19, 104),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width / 16, vertical: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CarouselSlider(
                                items: [
                                  //1st Image of Slider
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 30, 0, 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child:
                                                ProfileViewCarouselHomeWidget(
                                                    size: size),
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.topCenter,
                                            child: LiveTextWidgetCarousel())
                                      ],
                                    ),
                                  ),
                                ],
                                options: CarouselOptions(
                                  height: size.width * .45,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  // aspectRatio: 4 / 3,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  viewportFraction: 1,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  TalkToExpertsScreen(),
                                            ));
                                          },
                                          child:
                                              ConnectWithExpertsHomeScreenWidget(
                                                  size: size)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      GetDetailedReportHomeScreenWidget(
                                          size: size)
                                    ],
                                  ),
                                  ShopSitareContainerWidget(size: size)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconContainerWidget(
                                      size: size,
                                      icon: Icons.menu_book_rounded,
                                      label: 'KNOWLEDGE BASE'),
                                  IconContainerWidget(
                                      size: size,
                                      icon: Icons.update,
                                      label: 'YOUR ORDERS'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BuyNowHomeScreenWidget(size: size),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('data');
          }
        });
  }
}
