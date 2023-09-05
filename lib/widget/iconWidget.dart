import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

class IconContainerWidget extends StatelessWidget {
  const IconContainerWidget(
      {super.key, required this.size, required this.icon, required this.label});
  final Size size;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: size.width / 2 - size.width / 12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: Colors.white),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            child: Container(
              height: 45,
              width: 50,
              child: Icon(
                icon,
                color: whiteColor,
                size: 30,
              ),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
