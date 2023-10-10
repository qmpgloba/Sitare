import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class FilterSectionHeader extends StatelessWidget {
  const FilterSectionHeader({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 16, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.clear,
                  color: blackColor,
                ),
                label: const Text(
                  'Clear',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: blackColor),
                ))
          ],
        ),
      ),
    );
  }
}
