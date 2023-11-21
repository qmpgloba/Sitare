import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactIconShimmerWidget extends StatelessWidget {
  const ContactIconShimmerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.white70,
          highlightColor: Colors.white38,
          child: CircleAvatar(
            radius: size.width * .03,
            backgroundColor: Colors.white12,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Shimmer.fromColors(
          baseColor: Colors.white70,
          highlightColor: Colors.white38,
          child: Container(
            color: Colors.white12,
            height: 10,
            width: 50,
          ),
        )
      ],
    );
  }
}
