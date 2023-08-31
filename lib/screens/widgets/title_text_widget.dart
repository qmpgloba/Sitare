import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: FONT_COLOR),
    );
  }
}