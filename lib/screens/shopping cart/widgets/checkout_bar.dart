import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text(
                'Total :₹5000/-',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Saved :₹500/-',
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: whiteColor,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.width * 0.005,
              ),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text(
              'CHECKOUT',
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}