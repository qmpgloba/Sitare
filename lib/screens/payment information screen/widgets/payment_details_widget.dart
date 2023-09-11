
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

import 'payment_details_row_widget.dart';

class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({
    super.key,
    required this.size,
    required this.totalAmount,
    required this.gstAmount,
    required this.payableAmount,
  });

  final Size size;
  final double totalAmount;
  final double gstAmount;
  final double payableAmount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(size.width / 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment details:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            PaymentDetailsRowWidget(
                amount: totalAmount, text: 'Total Amount'),
            const Divider(
              thickness: 2,
              color: greyColor,
            ),
            PaymentDetailsRowWidget(amount: gstAmount, text: 'GST @ 18%'),
            const Divider(
              thickness: 2,
              color: greyColor,
            ),
            PaymentDetailsRowWidget(
                amount: payableAmount, text: 'Total Amount'),
          ],
        ),
      ),
    );
  }
}
