import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/screens/home%20screen/widgets/contact_icon_home_widget.dart';

import '../../../constants/ui_constants.dart';

class GetDetailedReportHomeScreenWidget extends StatelessWidget {
  const GetDetailedReportHomeScreenWidget({
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
              ContactIconHomeScreen(icon: Icons.insert_drive_file_outlined),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AutoSizeText(
            'GET DETAILED REPORT',
            maxFontSize: 12,
            maxLines: 1,
            minFontSize: 8,
            style: TextStyle(color: whiteColor),
          )
        ],
      ),
    );
  }
}
