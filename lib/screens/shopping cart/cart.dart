import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/contact%20functions/contact_functions.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';
import 'package:sitare/screens/widgets/wallet_amount.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'SITARE',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WalletRechargeScreen(),
              ));
            },
            icon: const Icon(
              Icons.account_balance_wallet_outlined,
              color: greyColor,
            ),
            label: const WalletAmount(color: greyColor, fontSize: 18),
          ),
          IconButton(
            onPressed: () {
              sendBookingNotification();
            },
            icon: const Icon(
              Icons.notifications_none,
              color: greyColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                bottom: size.width * 0.05,
              ),
              child: Card(
                color: greyColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    top: size.width * 0.05,
                    bottom: size.width * 0.05,
                  ),
                  child: SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.2,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://m.media-amazon.com/images/I/41I+seAwk1L.jpg',
                          width: size.width * 0.3,
                          height: size.height * 0.25,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                              child: const AutoSizeText(
                                'Black Fish Evil eye',
                                maxFontSize: 18,
                                maxLines: 1,
                                minFontSize: 14,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: size.width * 0.3,
                              child: const AutoSizeText(
                                'Handmade 925 silver bracelet',
                                maxFontSize: 14, textScaleFactor: 0.75,
                                // wrapWords: true,
                                maxLines: 2,
                                minFontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            const Expanded(
                              child: SizedBox(
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        '2555',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                            // SizedBox(width: ,
                            //   child: Text(
                            //     'Black Fish Evil eye',
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
