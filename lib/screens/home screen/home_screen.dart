import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/home%20screen/widgets/user_details_drawer_header.dart';

import 'widgets/list_items_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(size.width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserDetailsDrawerHeader(
                  size: size,
                  fullName: 'fullName',
                  email: 'email',
                  phoneNumber: 'phoneNumber'),
              const ListItemsDrawer(icon: Icons.home_outlined, text: 'Home'),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet_outlined),
                title: const AutoSizeText('Wallet',maxLines: 1,),
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
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        child: AutoSizeText(
                          'RECHARGE',maxLines: 1,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              const ListItemsDrawer(icon: Icons.list, text: 'Order History'),
              const Divider(),
              const ListItemsDrawer(
                  icon: Icons.wechat_outlined, text: 'Customer Support'),
              const Divider(),
              const ListItemsDrawer(
                  icon: Icons.settings_outlined, text: 'Settings'),
              const Divider(),
              const ListItemsDrawer(icon: Icons.share_outlined, text: 'Share'),
              const Spacer(),
              const Text('Version 1.0')
            ],
          ),
        ),
      ),
    );
  }
}
