import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
 int _counter = 1;

  @override
  Widget build(BuildContext context) {
    return CartStepperInt(
      style: const CartStepperStyle(
        shape: BoxShape.rectangle,
        radius: Radius.circular(4),
        activeBackgroundColor: greyColor,
        buttonAspectRatio: 1.2,
        textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: _counter,
      size: widget.size.width * 0.05,
      didChangeCount: (count) {
        setState(() {
          _counter = count;
        });
      },
    );
  }
}
