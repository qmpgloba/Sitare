
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/astrologers/astrologer_details.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/home%20screen/widgets/profile_widget_carousel.dart';
import 'package:sitare/screens/home%20screen/widgets/shimmer/profilewidget_carousal.dart';

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
          return  Center(child: CarouselSliderWidget(size: size));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          List<AstrologerModel> liveAstrologers = snapshot.data!;
          return CarouselSlider(
        items: liveAstrologers.map((astrologer) {
    return Container(
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: ProfileViewCarouselHomeWidget(
                size: size,
                astrologer: astrologer,
              ),
            ),
          ),
          // const Align(
          //   alignment: Alignment.topCenter,
          //   child: LiveTextWidgetCarousel(),
          // )
        ],
      ),
    );
  }).toList(),
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
    return const SizedBox();
   }} );
  }
}
