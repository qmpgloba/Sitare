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
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade200,
          child: CircleAvatar(
            radius: size.width * .03,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade200,
          child: Container(
            color: Colors.grey.shade100,
            height: 10,
            width: 50,
          ),
        )
      ],
    );
  }
}
