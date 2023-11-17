import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/ui_constants.dart';
import 'contact_icon_home_widget.dart';

class ConnectWithExpertsHomeScreenWidget extends StatelessWidget {
  const ConnectWithExpertsHomeScreenWidget({
    super.key,
    required this.size,
  });
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2 - size.width / 12,
      height: size.width / 4,
      decoration: BoxDecoration(
          color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(10)),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ContactIconHomeScreen(icon: Icons.chat_outlined),
              ContactIconHomeScreen(icon: Icons.call_outlined),
              ContactIconHomeScreen(icon: Icons.video_call_outlined),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AutoSizeText('CONNECT WITH EXPERTS',
              maxFontSize: 12,
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(color: whiteColor))
        ],
      ),
    );
  }
}
