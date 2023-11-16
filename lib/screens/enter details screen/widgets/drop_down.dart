import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    super.key,
    required this.context,
    required this.label,
    required this.onChanged,
    required this.dropDownCategory,
    required this.dropDownValue,
  });

  final BuildContext context;
  final String label;
  final Function(String? p1) onChanged;
  final String? dropDownCategory;
  final List<String>? dropDownValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: size.height * 0.06,
                child: DropdownButton<String>(
                  dropdownColor: PRIMARY_COLOR,
                  value: dropDownCategory,
                  hint: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: FONT_COLOR,
                    ),
                  ),
                  items: dropDownValue!.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: Text(
                          value,
                          style: const TextStyle(color: FONT_COLOR),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  isExpanded: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
