import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class contactIconHomeScreen extends StatelessWidget {
  const contactIconHomeScreen({
    super.key, required this.icon,
  });

final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor:redColor,
          radius: 17,
          child: Icon(
            icon,
            size: 20,
            color: FONT_COLOR,
          ),
        );
  }
}

