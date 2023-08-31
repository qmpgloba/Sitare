import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizeTextWidget extends StatelessWidget {
  const AutoSizeTextWidget({
    super.key, required this.text, required this.maxLines, required this.fontSize, required this.fontColor,
  });
  final String text;
  final int maxLines;
  final double fontSize;
  final Color fontColor;


  @override
  Widget build(BuildContext context) {
    return  AutoSizeText(
      text,
      style: TextStyle(fontSize: fontSize, color: fontColor),
      maxLines: maxLines,
    );
  }
}