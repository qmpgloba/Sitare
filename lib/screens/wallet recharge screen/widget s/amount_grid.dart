// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/amount_container_widget.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/widget%20s/triangle_widget.dart';

class AmountGridWidget extends StatefulWidget {
  AmountGridWidget({
    super.key,
    required this.size,
    required this.amountList,
    required this.selectedFilterIndex,
    required this.amountController,
  });

  final Size size;
  final List<String> amountList;
  int selectedFilterIndex;
  TextEditingController amountController;

  @override
  State<AmountGridWidget> createState() => _AmountGridWidgetState();
}

class _AmountGridWidgetState extends State<AmountGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: widget.size.width * 0.05,
          mainAxisSpacing: widget.size.width * 0.05,
          childAspectRatio: 2,
        ),
        itemCount: widget.amountList.length,
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = widget.selectedFilterIndex == index;
          return Stack(
            children: [
              AmountContainer(
                amount: widget.amountList[index],
                onTap: () {
                  setState(() {
                    widget.amountController.text = widget.amountList[index];
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
      ),
    );
  }
}
