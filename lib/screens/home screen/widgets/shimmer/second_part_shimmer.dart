import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare/screens/home%20screen/widgets/shimmer/connect_deatil_widget.dart';
import 'package:sitare/screens/home%20screen/widgets/shimmer/icon_container_shimmer.dart';
import 'package:sitare/screens/home%20screen/widgets/shimmer/profilewidget_carousal.dart';

class SecondPartShimmer extends StatelessWidget {
  const SecondPartShimmer({
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
            topRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width / 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSliderWidget(size: size),
                ConnectAndDetailWidget(size: size),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                IconContainerShimmerWidget(size: size),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.white60,
                  highlightColor: Colors.white38,
                  child: Container(
                    height: 140,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
