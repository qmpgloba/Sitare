
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class UpdateButtonWidget extends StatelessWidget {
  const UpdateButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.circular(3)),
      child: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 10, vertical: 10),
        child: AutoSizeText(
          'UPDATE',
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: whiteColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}