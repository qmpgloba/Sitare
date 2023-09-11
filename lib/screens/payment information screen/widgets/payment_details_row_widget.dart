
import 'package:flutter/material.dart';

class PaymentDetailsRowWidget extends StatelessWidget {
  const PaymentDetailsRowWidget({
    super.key,
    required this.amount,
    required this.text,
  });

  final double amount;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
        ),
        Text('₹$amount', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16))
      ],
    );
  }
}
