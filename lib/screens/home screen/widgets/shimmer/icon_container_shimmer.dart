import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IconContainerShimmerWidget extends StatelessWidget {
  const IconContainerShimmerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.white60,
          highlightColor: Colors.white38,
          child: Container(
            // height: 50,
            width: size.width / 2 - size.width / 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.white12,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.white60,
                    highlightColor: Colors.white38,
                    child: Container(
                      height: 45,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Shimmer.fromColors(
          baseColor: Colors.white60,
          highlightColor: Colors.white38,
          child: Container(
            // height: 50,
            width: size.width / 2 - size.width / 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.white12,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.white60,
                    highlightColor: Colors.white38,
                    child: Container(
                      height: 45,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
