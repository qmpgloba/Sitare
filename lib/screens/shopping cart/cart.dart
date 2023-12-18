import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/contact%20functions/contact_functions.dart';
import 'package:sitare/screens/shopping%20cart/widgets/product_card.dart';
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
      backgroundColor: whiteColor,
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
                top: size.width * 0.05,
                left: size.width * 0.05,
                right: size.width * 0.05,
                bottom: size.width * 0.05,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ProductCard(
                    size: size,
                    image:
                        'https://m.media-amazon.com/images/I/41I+seAwk1L.jpg',
                    title: 'Black Fish Evil eye',
                    description: 'Handmade 925 silver bracelet',
                    price: '2555',
                  ),
                  ProductCard(
                    size: size,
                    image:
                        'https://m.media-amazon.com/images/I/41I+seAwk1L.jpg',
                    title: 'Black Fish Evil eye',
                    description: 'Handmade 925 silver bracelet',
                    price: '2555',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
