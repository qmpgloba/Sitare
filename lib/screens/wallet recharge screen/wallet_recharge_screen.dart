// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/model/user_model.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
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
  double? balance;
  int selectedFilterIndex = 0;
  final _razorpay = Razorpay();
  // var userData = {};

  TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // balance = updateBalance(amountController.text);
    // retrieveBalanceFromFirestore();
    retrieveBalanceFromFirestore();
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    amountController.clear();
    super.dispose();
  }

  fetchAndSetBalance() async {
    double fetchedBalance = await retrieveBalanceFromFirestore();
    setState(() {
      balance = fetchedBalance;
    });
    print('Balance after fetchAndSetBalance: $balance');
  }

  @override
  Widget build(BuildContext context) {
    print('build ${userData!['wallet']}');
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
              // child: Text(
              //   "Available balance: Rs: ${retrieveBalanceFromFirestore().toString()}",
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading balance..');
                  } else if (snapshot.hasError) {
                    return const Text('Error loading balance');
                  } else {
                    var documents = snapshot.data!.docs;
                    if (documents.isNotEmpty) {
                      // Accessing the first document in the snapshot
                      var firstDocument = documents.first;
                      dynamic walletValue = firstDocument['wallet'];

                      print('Balance in FutureBuilder: $walletValue');

                      return Text(
                        'Available balance: Rs: $walletValue',
                      );
                    } else {
                      return const Text(
                        'Document does not exist or does not have a "wallet" field',
                      );
                    }
                  }
                },
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    User? user = FirebaseAuth.instance.currentUser;
    print('Success=${response.paymentId}');
    if (user != null) {
      double rechargeAmount = double.parse(amountController.text);
      double updateAmount = double.parse(userData!['wallet']) +
          double.parse(amountController.text);
      // double updatedBalance = updateBalance(rechargeAmount.toString());
      print("haii $updateAmount");
      await updateWallet(user.uid, updateAmount);

      FirebaseFirestore.instance.collection('payments').add({
        'uid': user.uid,
        'amount': rechargeAmount.toString(),
        'transaction id': response.paymentId,
        'time': FieldValue.serverTimestamp(),
      });

      showSnackbar(context, 'Payment Successful', greenColor);
    }
  }

  // void _handlePaymentSuccess(
  //   PaymentSuccessResponse response,
  // ) {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   print('Succes=${response.paymentId}');
  //   if (user != null) {
  //     FirebaseFirestore.instance.collection('payments').add({
  //       'uid': user.uid,
  //       'amount': amountController.text,
  //       'transaction id': response.paymentId,
  //       'time': FieldValue.serverTimestamp()
  //     });
  //     setState(() {
  //       balance = updateBalance(amountController.text);
  //       updateWallet(user.uid, balance!);
  //     });
  //     showSnackbar(context, 'Payment Succssfull', greenColor);
  //   }
  // }

  void _handlePaymentError(PaymentFailureResponse response) {
    showAlertBox(context, 'Transaction Failed', whiteColor, 'ok');
    print('Failed');
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
          'contact': '1234567890',
          'email': 'hi@gmail.com',
        }
      };
      _razorpay.open(options);
      setState(() {});
    } on Exception catch (e) {
      print('Error on parsing amount:$e');
    }
  }

  // updateBalance(String amount) {
  //   double updatedBalance = balance!;

  //   try {
  //     double enteredAmount = double.parse(amountController.text);
  //     updatedBalance += enteredAmount;
  //   } catch (e) {
  //     print('Error parsing amount: $e');
  //     // Handle the error, you might want to show a message to the user
  //   }
  //   return updatedBalance;
  // }

  updateWallet(String userId, double amount) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance;

    try {
      // Fetch the user document
      QuerySnapshot snapshot =
          await db.collection('users').where('uid', isEqualTo: userId).get();
      // DocumentSnapshot<Object?> documentSnapshot = await userDocRef.get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = snapshot.docs.first;
        await documentSnapshot.reference.update({'wallet': amount.toString()});
        print('Wallet updated');
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error updating wallet: $e');
    }
    // return amount;
    // print(amount);
  }

  Future<double> retrieveBalanceFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (snapshot.exists) {
          double walletValue = (snapshot.data()?['wallet'] ?? 0).toDouble();
          print('Retrieved balance from Firestore: $walletValue');
          return walletValue;
        }
      } catch (e) {
        print('Error retrieving balance from Firestore: $e');
        rethrow; // Propagate the error
      }
    }
    return balance ?? 0.0; // Return 0.0 if balance is null
  }
}
