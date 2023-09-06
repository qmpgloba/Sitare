import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/home%20screen%20combined/widgets/connect_with_experts_widget.dart';
import 'package:sitare/screens/home%20screen%20combined/widgets/get_detailed_report_widget.dart';
import 'package:sitare/screens/home%20screen%20combined/widgets/shop_sitare_container_widget.dart';

import 'widgets/live_text_widget_carousel.dart';
import 'widgets/profile_widget_carousel.dart';

class HomeScreenStackWidget extends StatelessWidget {
  const HomeScreenStackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(),
      body: Container(
        
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 8, 19, 104),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width/16,vertical: 10),
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
                            padding:  const EdgeInsets.fromLTRB(0, 30, 0, 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ProfileViewCarouselHomeWidget(size: size),
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
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    children: [
                      ConnectWithExpertsHomeScreenWidget(size: size),
                    const SizedBox(height: 15,),
                    GetDetailedReportHomeScreenWidget(size: size)
                    ],
                  ),
                  ShopSitareContainerWidget(size: size)
                  
                ],),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconContainerWidget(size: size, icon: Icons.menu_book_rounded, label: 'KNOWLEDGE BASE'),
                    IconContainerWidget(size: size, icon: Icons.update, label: 'YOUR ORDERS'),
                  ],
                ),
                const SizedBox(height: 10,),
                BuyNowHomeScreenWidget(size: size),
                
              ],
            ),
          ),
        ),
      ), 
    );
  }
}

class BuyNowHomeScreenWidget extends StatelessWidget {
  const BuyNowHomeScreenWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
              alignment:
      Alignment.center, // Center the content within the stack
              children: [
    Container(
      height: 140,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          "assets/images/walpaper.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ),
    Positioned(
      top: 20,
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Energized rosary wearing & chanting mantras",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green),
              child: const Center(
                  child: Text(
                "BUY NOW",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )),
            )
          ],
        ),
      ),
    ),
              ],
            );
  }
}



class IconContainerWidget extends StatelessWidget {
  const IconContainerWidget(
      {super.key, required this.size, required this.icon, required this.label});
  final Size size;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: size.width/2-size.width/12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: Colors.white),
      child: Row(
        children: [
          Padding(
            padding:  const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
            child: Container(
              height: 45,
              width: 50,
              child: Icon(icon,color:whiteColor,size: 30,),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}