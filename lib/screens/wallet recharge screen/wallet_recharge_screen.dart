// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/widget%20s/amount_container_widget.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/widget%20s/triangle_widget.dart';
import 'package:sitare/screens/widgets/show_dialog_widget.dart';
import 'package:sitare/screens/widgets/snackbar.dart';

class WalletRechargeScreen extends StatefulWidget {
  const WalletRechargeScreen({super.key});

  @override
  State<WalletRechargeScreen> createState() => _WalletRechargeScreenState();
}

class _WalletRechargeScreenState extends State<WalletRechargeScreen> {
  double balance = 4.0;
  int selectedFilterIndex = 0;
  final _razorpay = Razorpay();

  TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var updatedBalance = updateBalance(amountController.text);
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
                "Available balance: Rs: $updatedBalance",
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
                  GestureDetector(
                    onTap: () {
                      print(amountController.text);
                      onTapRecharge(amount: amountController.text);
                    },
                    child: Container(
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

  void _handlePaymentSuccess(
    PaymentSuccessResponse response,
  ) {
    User? user = FirebaseAuth.instance.currentUser;
    print('Succes=${response.paymentId}');
    if (user != null) {
      FirebaseFirestore.instance.collection('payments').add({
        'uid': user.uid,
        'amount': amountController.text,
        'transaction id': response.paymentId,
        'time': FieldValue.serverTimestamp()
      });
      showSnackbar(context, 'Payment Succssfull', greenColor);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showAlertBox(context, 'Transaction Failed', whiteColor, 'ok');
    print('Error');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showAlertBox(
      context,
      'Transaction Failed due to involvement of external wallet',
      whiteColor,
      'ok',
    );

    print('External');
  }

  onTapRecharge({required String amount}) {
    try {
      int parsedAmount = (double.parse(amount) * 100).toInt();

      var options = {
        'key': 'rzp_test_SG8DKDs1zi5E3l',
        'amount': parsedAmount, //in the smallest currency sub-unit.
        'name': 'Qmp Global',
        // Generate order_id using Orders API
        'timeout': 180, // in seconds
        'prefill': {
          'contact': '9747119764',
          'email': 'hi@gmail.com',
        }
      };
      _razorpay.open(options);
      setState(() {
        balance = updateBalance(amount);
      });
    } on Exception catch (e) {
      print('Error on parsing amount:$e');
    }
  }

  updateBalance(String amount) {
    double updatedBalance = balance;

    try {
      double enteredAmount = double.parse(amountController.text);
      updatedBalance += enteredAmount;
    } catch (e) {
      print('Error parsing amount: $e');
      // Handle the error, you might want to show a message to the user
    }
    return updatedBalance;
  }
}
