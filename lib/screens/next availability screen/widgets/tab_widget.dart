
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tomorrow, 05 Sep'),
          Text(
            'Available',
            style: TextStyle(color: greenColor),
          )
        ],
      ),
      // text: 'Tomorrow, 05 Aug',
    );
  }
}
