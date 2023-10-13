
import 'package:flutter/material.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/home%20screen/widgets/silding_container_widget.dart';

class SlidingPartWidget extends StatelessWidget {
  const SlidingPartWidget({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: sliderOptions.length * 2,
        itemBuilder: (context, index) {
          final adjustedIndex = index % sliderOptions.length;
          return HomeScreenSlidingContainerWidget(adjustedIndex: adjustedIndex);
        },
      ),
    );
  }
}

