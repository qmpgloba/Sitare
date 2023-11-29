import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare/constants/ui_constants.dart';

class MyBookingsShimmer extends StatelessWidget {
  const MyBookingsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width / 25),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: size.width * .07,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shimmerContainer(size),
                              shimmerContainer(size),
                              shimmerContainer(size),
                              shimmerContainer(size)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: backgroundColor,
                )
              ],
            ),
          );
        },
      ),
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
