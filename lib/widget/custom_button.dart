import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 328,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: FONT_COLOR,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              color: FONT_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
