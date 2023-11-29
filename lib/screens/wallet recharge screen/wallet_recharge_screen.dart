// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/wallet%20function/wallet.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/widget%20s/available_balance.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/widget/amount_grid.dart';
import 'package:sitare/screens/widgets/show_dialog_widget.dart';
import 'package:sitare/screens/widgets/snackbar.dart';

class WalletRechargeScreen extends StatefulWidget {
  const WalletRechargeScreen({Key? key}) : super(key: key);

  @override
  State<WalletRechargeScreen> createState() => _WalletRechargeScreenState();
}

class _WalletRechargeScreenState extends State<WalletRechargeScreen> {
  double? balance;
  int selectedFilterIndex = 0;
  final _razorpay = Razorpay();
  TextEditingController amountController = TextEditingController();
  bool _isMounted = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _isMounted = true;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false;
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldKey,
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
            const AvailableBalance(),
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
              child: AmountGrid(
                amountList: amountList,
                amountController: amountController,
                size: size,
                selectedFilterIndex: selectedFilterIndex,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    User? user = FirebaseAuth.instance.currentUser;
    print('Success=${response.paymentId}');
    if (user != null) {
      double rechargeAmount = double.parse(amountController.text);
      double updateAmount = double.parse(userData!['wallet']) +
          double.parse(amountController.text);
      print("haii $updateAmount");
      await updateWallet(user.uid, updateAmount);

      FirebaseFirestore.instance.collection('payments').add({
        'uid': user.uid,
        'amount': rechargeAmount.toString(),
        'transaction id': response.paymentId,
        'time': FieldValue.serverTimestamp(),
      });

      amountController.clear();
      if (_isMounted) {
        showSnackbar(context, 'Payment Successful', greenColor);
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (_isMounted) {
      showAlertBox(context, 'Transaction Failed', whiteColor, 'ok');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (_isMounted) {
      showAlertBox(
        context,
        'Transaction Failed due to involvement of an external wallet',
        whiteColor,
        'ok',
      );
    }
  }

  onTapRecharge({required String amount}) {
    try {
      int parsedAmount = (double.parse(amount) * 100).toInt();

      var options = {
        'key': 'rzp_test_SG8DKDs1zi5E3l',
        'amount': parsedAmount,
        'name': 'Qmp Global',
        'timeout': 180,
        'prefill': {
          'contact': '1234567890',
          'email': 'hi@gmail.com',
        }
      };
      _razorpay.open(options);
    } on Exception catch (e) {
      print('Error on parsing amount: $e');
    }
  }
}
