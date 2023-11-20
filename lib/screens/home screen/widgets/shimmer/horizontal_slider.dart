import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';

class HorizontalSliderShimmer extends StatelessWidget {
  const HorizontalSliderShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.white60,
            highlightColor: Colors.white38,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white30,
              ),
              width: 135,
            ),
          );
        },
        itemCount: sliderOptions.length,
      ),
    );
  }
}
