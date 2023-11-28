// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/amount_container_widget.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/widget/triangle_widget.dart';

class AmountGrid extends StatefulWidget {
  AmountGrid({
    super.key,
    required this.size,
    required this.amountController,
    required this.selectedFilterIndex,
  });
  TextEditingController amountController;
  final Size size;
  int selectedFilterIndex;

  @override
  State<AmountGrid> createState() => _AmountGridState();
}

class _AmountGridState extends State<AmountGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: widget.size.width * 0.05,
        mainAxisSpacing: widget.size.width * 0.05,
        childAspectRatio: 2,
      ),
      itemCount: amountList.length,
      itemBuilder: (BuildContext context, int index) {
        bool isSelected = widget.selectedFilterIndex == index;
        return Stack(
          children: [
            AmountContainer(
              amount: amountList[index],
              onTap: () {
                setState(() {
                  widget.amountController.text = amountList[index];
                  widget.selectedFilterIndex = index;
                });
              },
            ),
            if (isSelected)
              const Positioned(
                child: TriangleWidget(
                  size: 25,
                  color: Colors.red,
                ),
              ),
          ],
        );
      },
    );
  }
}
