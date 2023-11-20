import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ConnectAndDetailWidget extends StatelessWidget {
  const ConnectAndDetailWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            shimmerBox(),
            const SizedBox(
              height: 15,
            ),
            shimmerBox()
          ],
        ),
        const SizedBox(width: 10),
        shopSitareShimmerBox(size)
      ],
    );
  }

  Shimmer shimmerBox() {
    return Shimmer.fromColors(
      baseColor: Colors.white60,
      highlightColor: Colors.white38,
      child: Container(
        width: size.width / 2 - size.width / 12,
        height: size.width / 4,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10),
        ),
        // child:  ,
      ),
    );
  }

  Shimmer shopSitareShimmerBox(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.white60,
      highlightColor: Colors.white38,
      child: Container(
        color: Colors.white12,
        height: (size.width / 2) + 15,
        width: size.width / 2 - size.width / 12,
      ),
    );
  }
}
