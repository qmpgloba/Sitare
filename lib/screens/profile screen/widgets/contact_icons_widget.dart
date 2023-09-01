
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class ContactIconWidget extends StatelessWidget {
  const ContactIconWidget({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 13,
          child: Icon(
            icon,
            size: 13,
          ),
        ),
        AutoSizeText(
          text,style: const TextStyle(fontSize: 10,color: whiteColor),
          minFontSize: 8,
          maxLines: 1,
        )
      ],
    );
  }
}
