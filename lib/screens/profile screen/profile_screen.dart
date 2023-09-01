import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

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
        title: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,color: whiteColor),),
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.zero),
              backgroundColor: MaterialStatePropertyAll(PRIMARY_COLOR),elevation: MaterialStatePropertyAll(0)
            ),
            onPressed: () {
            
          }, icon: Icon(Icons.account_balance_wallet_outlined,color: greyColor,), label: Text('₹$walletBalnce',style: TextStyle(fontSize: 18,color: greyColor),)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.share_outlined,color: greyColor,))
        ],
      ),
      body: Column(children: [
        Container(
          width: size.width,
          height: size.width*.6,
          decoration: BoxDecoration(
            
            image: DecorationImage(image: NetworkImage('https://shreepng.com/img/OutSide/Celebrities/SmritiMandhana/Smriti%20Mandhana.png',),fit: BoxFit.contain)),
           ),
      ],),
    );
  }
}