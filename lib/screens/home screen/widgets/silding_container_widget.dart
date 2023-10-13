
import 'package:flutter/material.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';

class HomeScreenSlidingContainerWidget extends StatelessWidget {
  const HomeScreenSlidingContainerWidget({
    super.key,
    required this.adjustedIndex,
  });

  final int adjustedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      width: 135,
      child: ListTile(
        title: Center(
          child: Text(
            sliderOptions[adjustedIndex],
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}