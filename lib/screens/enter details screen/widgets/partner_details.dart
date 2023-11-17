// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/details%20functions/details_functions.dart';

class PartnerDetailsWidget extends StatefulWidget {
  PartnerDetailsWidget({
    super.key,
    required this.size,
    required this.optionalField,
    required this.length,
  });
  final Size size;
  late int length;
  final List<String> optionalField;

  @override
  State<PartnerDetailsWidget> createState() => _PartnerDetailsWidgetState();
}

class _PartnerDetailsWidgetState extends State<PartnerDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: widget.size.height * 0.02),
      shrinkWrap: true,
      itemCount: widget.length,
      itemBuilder: (context, index) {
        if (widget.optionalField.length <= index) {
          widget.optionalField.add('');
        }

        return TextFormField(
          style: const TextStyle(
            color: FONT_COLOR,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            hintText: "Partner Details (Optional)",
            hintStyle: const TextStyle(
              color: FONT_COLOR,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: whiteColor,
              ),
            ),
            suffixIcon: index == 0
                ? InkWell(
                    onTap: () {
                      setState(() {
                        ++widget.length;
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: FONT_COLOR,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        --widget.length;
                      });
                    },
                    child: const Icon(
                      Icons.remove,
                      color: FONT_COLOR,
                    ),
                  ),
          ),
          onChanged: (v) {
            widget.optionalField[index] = v;
          },
        );
      },
    );
  }
}
