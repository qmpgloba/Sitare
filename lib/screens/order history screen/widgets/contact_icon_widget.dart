
import 'package:flutter/material.dart';

class ConatctIconWidget extends StatelessWidget {
  const ConatctIconWidget({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 13,
      child: Icon(
        icon,
        size: 13,
      ),
    );
  }
}