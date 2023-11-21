import 'package:flutter/material.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/widgets/shimmer/contact_icon_shimmer.dart';

class ContactIconShimmerGroup extends StatelessWidget {
  const ContactIconShimmerGroup({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactIconShimmerWidget(size: size),
        const SizedBox(
          height: 5,
        ),
        ContactIconShimmerWidget(size: size),
        const SizedBox(
          height: 5,
        ),
        ContactIconShimmerWidget(size: size),
      ],
    );
  }
}
