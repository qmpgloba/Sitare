import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/home%20screen/widgets/shimmer/horizontal_slider.dart';
import 'package:sitare/screens/home%20screen/widgets/shimmer/second_part_shimmer.dart';

class HomeScreenShimmerEffect extends StatefulWidget {
  const HomeScreenShimmerEffect({super.key});

  @override
  State<HomeScreenShimmerEffect> createState() =>
      _HomeScreenShimmerEffectState();
}

class _HomeScreenShimmerEffectState extends State<HomeScreenShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'SITARE',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.account_balance_wallet_outlined,
              color: greyColor,
            ),
            label: const Text(
              '₹0',
              style: TextStyle(fontSize: 18, color: greyColor),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: greyColor,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width / 15),
            child: Shimmer.fromColors(
              baseColor: Colors.white60,
              highlightColor: Colors.white38,
              child: Container(
                color: Colors.white12,
                width: 100,
                height: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          HorizontalSliderShimmer(size: size),
          const SizedBox(height: 10),
          SecondPartShimmer(size: size)
        ],
      ),
    );
  }
}
