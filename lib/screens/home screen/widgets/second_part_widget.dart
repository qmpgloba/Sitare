
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/talk_to_experts_screen.dart';
import 'package:sitare/widget/buynow_homescreen_widget.dart';
import 'package:sitare/widget/connect_with_experts_widget.dart';
import 'package:sitare/widget/get_detail_report_widget.dart';
import 'package:sitare/widget/icon_widget.dart';
import 'package:sitare/widget/live_text_widget_carousel.dart';
import 'package:sitare/widget/profile_widget_carousel.dart';
import 'package:sitare/widget/shop_sitare_container_widget.dart';

class SecondPartWidget extends StatelessWidget {
  const SecondPartWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    height: size.width * .5,
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
                                    const TalkToExpertsScreen(),
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
    );
  }
}
