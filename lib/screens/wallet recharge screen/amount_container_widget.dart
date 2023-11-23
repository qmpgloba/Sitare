import 'package:flutter/material.dart';
import '../../constants/ui_constants.dart';

class AmountContainer extends StatefulWidget {
  const AmountContainer({
    super.key,
    required this.amount,
    required this.onTap,
    // required this.color
  });
  final String amount;
  final VoidCallback onTap;
  //final Color color;

  @override
  State<AmountContainer> createState() => _AmountContainerState();
}

class _AmountContainerState extends State<AmountContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black45,
              width: 1,
            ),
            color: BOX_COLOR),
        child: Center(
          child: Text(
            "₹${widget.amount}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
