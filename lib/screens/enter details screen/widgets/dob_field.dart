import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class DobField extends StatelessWidget {
  const DobField({
    super.key,
    required this.dobController,
  });

  final TextEditingController dobController;

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
            "Date of Birth: ${dobController.text} ",
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
