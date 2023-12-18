
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/astrologers/astrologer_details.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/home%20screen/widgets/live_text_widget_carousel.dart';
import 'package:sitare/screens/home%20screen/widgets/profile_widget_carousel.dart';

class LiveAstrologersCarouselWidget extends StatelessWidget {
  const LiveAstrologersCarouselWidget({
    super.key,
    required this.size,
  });

  final Size size;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AstrologerModel>>(
      future: fetchFilteredAstrologersFromFirestore(),
      builder: (context,snapshot){
       if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SizedBox());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          List<AstrologerModel> liveAstrologers = snapshot.data!;
          return CarouselSlider(
        items: [
          //1st Image of Slider
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ProfileViewCarouselHomeWidget(size: size,astrologer: liveAstrologers[1],),
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: LiveTextWidgetCarousel(),
                )
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
      );
      
   }else{
    return SizedBox();
   }} );
  }
}
