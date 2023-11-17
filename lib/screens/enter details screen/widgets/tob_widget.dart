import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class TobWidget extends StatelessWidget {
  const TobWidget({
    super.key,
    required this.tobController,
  });

  final TextEditingController tobController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: whiteColor, width: 0.4),
        ),
      ),
      child: Row(
        children: [
          Text(
            "Time of Birth: ${tobController.text}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: FONT_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}
