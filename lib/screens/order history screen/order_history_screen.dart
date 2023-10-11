import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';

import 'widgets/order_history_profile_widget.dart';

// ignore: must_be_immutable
class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});
  num walletAmmount = 200;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: const Text(
            'Order History',
            style: TextStyle(color: whiteColor),
          ),
          bottom: PreferredSize(
              preferredSize: Size(size.width, size.width * .1),
              child: Padding(
                padding: EdgeInsets.all(size.width / 20),
                child: GestureDetector(
                  onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const WalletRechargeScreen(),
                              ));
                            },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: whiteColor,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '₹$walletAmmount',
                        style: const TextStyle(color: whiteColor, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(3)),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: AutoSizeText(
                            'RECHARGE',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                color: whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => OrderHistoryProfileTile(size: size),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 3));
  }
}


