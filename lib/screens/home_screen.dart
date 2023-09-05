import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';
import '../widget/buynow_homescreen_widget.dart';
import '../widget/connect_with_experts_widget.dart';
import '../widget/get_detail_report_widget.dart';
import '../widget/iconWidget.dart';
import '../widget/live_text_widget_carousel.dart';
import '../widget/profile_widget_carousel.dart';
import '../widget/shop_sitare_container_widget.dart';

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
  ScrollController _scrollController = ScrollController();
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
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'SITARE',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
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
      drawer: const Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left:size.width/16),
            child: const Text(
              "Hi Guru, Welcome",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Container(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ProfileViewCarouselHomeWidget(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              ConnectWithExpertsHomeScreenWidget(size: size),
                              const SizedBox(
                                height: 15,
                              ),
                              GetDetailedReportHomeScreenWidget(size: size)
                            ],
                          ),
                          ShopSitareContainerWidget(size: size)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }
}
