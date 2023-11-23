import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';

import 'package:sitare/screens/wallet%20recharge%20screen/widget%20s/amount_container_widget.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/widget%20s/triangle_widget.dart';

class WalletRechargeScreen extends StatefulWidget {
  const WalletRechargeScreen({super.key});

  @override
  State<WalletRechargeScreen> createState() => _WalletRechargeScreenState();
}

class _WalletRechargeScreenState extends State<WalletRechargeScreen> {
  // final _razorpay = Razorpay();

  double balance = 4.0;
  int selectedFilterIndex = 0;
  @override
  void initState() {
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Wallet Recharge",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: PRIMARY_COLOR,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.width / 15),
              child: Text(
                "Available balance: Rs: $balance",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Amount',
                        border: InputBorder
                            .none, // Remove the default border of TextFormField
                      ),
                    ),
                  ),
                  Container(
                    color: redColor,
                    height: 60,
                    width: size.width * 0.35,
                    child: const Center(
                      child: Text(
                        "Recharge",
                        style: TextStyle(color: whiteColor, fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: size.width * 0.05,
                  mainAxisSpacing: size.width * 0.05,
                  childAspectRatio: 2,
                ),
                itemCount: amountList.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = selectedFilterIndex == index;
                  return Stack(
                    children: [
                      AmountContainer(
                        amount: amountList[index],
                        onTap: () {
                          setState(() {
                            amountController.text = amountList[index];
                            selectedFilterIndex = index;
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
            )
          ],
        ),
      ),
    );
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   User user = FirebaseAuth.instance;
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   print('Error');
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   print('External');
  // }
}
