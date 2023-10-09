
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ResetButtonWidget extends StatelessWidget {
  const ResetButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3)),
      child: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 5, vertical: 2),
        child: AutoSizeText(
          'RESET',
          maxLines: 1,
          style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}