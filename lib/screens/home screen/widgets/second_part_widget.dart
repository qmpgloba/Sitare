import 'package:flutter/material.dart';
import 'package:sitare/screens/home%20screen/widgets/live_astrologers_carousel_widget.dart';
import 'package:sitare/screens/my%20bookings/my_bookings_screen.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/talk_to_experts_screen.dart';
import 'package:sitare/screens/home%20screen/widgets/buynow_homescreen_widget.dart';
import 'package:sitare/screens/home%20screen/widgets/connect_with_experts_widget.dart';
import 'package:sitare/screens/home%20screen/widgets/get_detail_report_widget.dart';
import 'package:sitare/screens/home%20screen/widgets/icon_widget.dart';
import 'package:sitare/screens/home%20screen/widgets/shop_sitare_container_widget.dart';

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
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width / 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LiveAstrologersCarouselWidget(size: size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TalkToExpertsScreen(),
                              ));
                            },
                            child:
                                ConnectWithExpertsHomeScreenWidget(size: size)),
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
                      label: 'KNOWLEDGE BASE',
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyBoookingsScreen(),
                        ));
                      },
                      child: IconContainerWidget(
                        size: size,
                        icon: Icons.update,
                        label: 'MY BOOKINGS',
                      ),
                    ),
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
