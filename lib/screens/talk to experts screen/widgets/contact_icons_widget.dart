
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ContactIconsTalkToExpertsScreen extends StatelessWidget {
  const ContactIconsTalkToExpertsScreen({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 13,
          child: Icon(
            icon,
            size: 13,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        AutoSizeText(
          text,
          style: const TextStyle(fontSize: 12),
          maxFontSize: 12,
          maxLines: 1,
        ),
      ],
    );
  }
}
