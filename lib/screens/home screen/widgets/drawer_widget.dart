
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/home%20screen/widgets/list_items_drawer.dart';
import 'package:sitare/screens/home%20screen/widgets/user_details_drawer_header.dart';
import 'package:sitare/screens/order%20history%20screen/order_history_screen.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';
import 'package:sitare/screens/welcome%20page/welcome_screen.dart';

class HomeScreenDrawerWidget extends StatelessWidget {
  const HomeScreenDrawerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // width: size.width*.7,
            child: UserDetailsDrawerHeader(
                size: size,
                fullName: userData!['full name'],
                email: userData!['email'],
                phoneNumber: userData!['phone number']),
          ),
          const ListItemsDrawer(
              icon: Icons.home_outlined, text: 'Home'),
          const Divider(),
          GestureDetector(
            onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const WalletRechargeScreen(),
                    ));
                  },
            child: ListTile(
              leading:
                  const Icon(Icons.account_balance_wallet_outlined),
              title: const AutoSizeText(
                'Wallet',
                maxLines: 1,
              ),
              trailing: Wrap(
                spacing: 5,
                children: [
                  const AutoSizeText(
                    '₹200.00',
                    maxLines: 1,
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: AutoSizeText(
                        'RECHARGE',
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrderHistoryScreen(),
                ));
              },
              child: const ListItemsDrawer(
                  icon: Icons.list, text: 'Order History')),
          const Divider(),
          GestureDetector(
            onTap: () {
              dynamic conversationObject = {
                'appId': '92f796d009e254c06686a249bd1b465b',
              };
              KommunicateFlutterPlugin.buildConversation(
                      conversationObject)
                  .then((clientConversationId) {})
                  .catchError((error) {});
            },
            child: const ListItemsDrawer(
                icon: Icons.wechat_outlined,
                text: 'Customer Support'),
          ),
          const Divider(),
          const ListItemsDrawer(
              icon: Icons.settings_outlined, text: 'Settings'),
          const Divider(),
          const ListItemsDrawer(
              icon: Icons.share_outlined, text: 'Share'),
          GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                      (route) => false);
                });
              },
              child: const ListItemsDrawer(
                  icon: Icons.logout, text: 'Logout')),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(size.width / 16),
            child: const Text('Version 1.0'),
          ),
        ],
      ),
    );
  }
}
