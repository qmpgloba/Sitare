import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

import 'widgets/coupon_code_widget.dart';
import 'widgets/payment_details_widget.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  double totalAmount = 500.0;
  double gstAmount = 90.0;
  double payableAmount = 590.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          'Payment Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
      ),
      body: Column(
        children: [
          PaymentDetailsWidget(size: size, totalAmount: totalAmount, gstAmount: gstAmount, payableAmount: payableAmount),
          CouponCodeWidget(size: size),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.maxFinite,
                // height: 30,
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Center(
                    child: AutoSizeText(
                      'PAY',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          color: whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
