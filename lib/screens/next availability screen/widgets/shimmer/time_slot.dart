import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare/constants/ui_constants.dart';

class TimeSlotShimmer extends StatelessWidget {
  const TimeSlotShimmer({
    super.key,
    required ScrollController scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2,
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6),
              ),
              height: 5,
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
