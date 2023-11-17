// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/amount_container_widget.dart';
import '../widget s/triangle_widget.dart';

class AmountGrid extends StatefulWidget {
  AmountGrid({
    super.key,
    required this.size,
    required this.amountList,
    required this.selectedFilterIndex,
    required this.amountController,
  });

  final Size size;
  final List<String> amountList;
  int selectedFilterIndex;
  final TextEditingController amountController;

  @override
  State<AmountGrid> createState() => _AmountGridState();
}

class _AmountGridState extends State<AmountGrid> {
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
