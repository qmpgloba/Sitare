import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/widgets/shimmer/contact_icon_group.dart';

class TalkToExpertShimmer extends StatefulWidget {
  const TalkToExpertShimmer({super.key});

  @override
  State<TalkToExpertShimmer> createState() => _TalkToExpertShimmerState();
}

class _TalkToExpertShimmerState extends State<TalkToExpertShimmer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(size.width / 20),
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: CircleAvatar(
                            radius: size.width * .12,
                            backgroundColor: Colors.grey.shade100,
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shimmerBox(),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: RatingBar.builder(
                                  initialRating: 5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 15,
                                  // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.grey.shade100,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              shimmerBox(),
                              const SizedBox(
                                height: 5,
                              ),
                              shimmerBox(),
                              const SizedBox(
                                height: 5,
                              ),
                              shimmerBox(),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(),
                        ContactIconShimmerGroup(size: size),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: LinearProgressIndicator(
                        value: .70,
                        color: Colors.grey.shade100,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }

  Shimmer shimmerBox() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
      child: Container(
        color: Colors.grey.shade100,
        height: 10,
        width: 100,
      ),
    );
  }
}
