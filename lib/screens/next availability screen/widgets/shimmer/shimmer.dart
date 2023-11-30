import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/next%20availability%20screen/widgets/shimmer/time_slot.dart';

class NextAvailabilityShimmer extends StatelessWidget {
  const NextAvailabilityShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          'Next Availability',
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Column(
            children: [
              height(),
              Row(
                children: [
                  width(),
                  CircleAvatar(
                    radius: size.width * .09,
                  ),
                  width(),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerContainer(size),
                        shimmerContainer(size),
                        shimmerContainer(size),
                      ],
                    ),
                  ),
                  height(),
                  Container(
                    color: backgroundColor,
                  ),
                ],
              ),
              height(),
              Container(
                color: backgroundColor,
                width: size.width,
                height: size.height * 0.1,
              ),
              height(),
              TimeSlotShimmer(scrollController: scrollController),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: backgroundColor,
                      height: 30,
                      width: size.width * 0.8,
                    ),
                    height()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox width() {
    return const SizedBox(
      width: 10,
    );
  }

  SizedBox height() {
    return const SizedBox(
      height: 10,
    );
  }

  shimmerContainer(Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: size.width * 0.25,
        height: 10,
        color: backgroundColor,
      ),
    );
  }
}
