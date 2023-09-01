import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/profile%20screen/widgets/astroleger_profile_details_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  num walletBalnce = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        actions: [
          ElevatedButton.icon(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  backgroundColor: MaterialStatePropertyAll(PRIMARY_COLOR),
                  elevation: MaterialStatePropertyAll(0)),
              onPressed: () {},
              icon: const Icon(
                Icons.account_balance_wallet_outlined,
                color: greyColor,
              ),
              label: Text(
                '₹$walletBalnce',
                style: const TextStyle(fontSize: 18, color: greyColor),
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share_outlined,
                color: greyColor,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.width * .6,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      'https://shreepng.com/img/OutSide/Celebrities/SmritiMandhana/Smriti%20Mandhana.png',
                    ),
                    fit: BoxFit.contain)),
          ),
          AstrologerProfileDetailsWidget(size: size, name: 'Smrithi Mandhana', department: 'Tarot,Numerology', languages: 'English,Hindi,Punjabi', rating: 5, yearsOfExperience: 15, rupees: 95)
        ],
      ),
    );
  }
}
