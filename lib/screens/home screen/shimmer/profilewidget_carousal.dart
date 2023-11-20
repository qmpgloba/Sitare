import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
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
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10)),
                  child: Shimmer.fromColors(
                    baseColor: Colors.white60,
                    highlightColor: Colors.white38,
                    child: Container(),
                  ),
                ),
              ),
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
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
    );
  }
}
