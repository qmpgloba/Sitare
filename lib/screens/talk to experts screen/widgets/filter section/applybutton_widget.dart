
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ApplyButtonWidget extends StatelessWidget {
  const ApplyButtonWidget({
    super.key, required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: size.width * 0.08,
        width: size.width * 0.25,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3)),
        child: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5, vertical: 2),
          child: Center(
            child: AutoSizeText(
              'APPLY',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}