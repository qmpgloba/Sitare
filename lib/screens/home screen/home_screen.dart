import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/functions/user_functions.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/home%20screen/widgets/drawer_widget.dart';
import 'package:sitare/screens/home%20screen/widgets/second_part_widget.dart';
import 'package:sitare/screens/home%20screen/widgets/sliding_part_widget.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';

Map<String, dynamic>? userData;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<String> sliderOptions = [
  'DAILY HOROSCOPE',
  'STUDY ASTROLOGY',
  'HOROSCOPE MATCHING',
  'ASTROLOGY MATCHING',
  'RELATIONSHIP STATUS',
  'MATRIMONIAL MATCHING',
];

class _HomeScreenState extends State<HomeScreen> {
  final int containerCount = 5;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < sliderOptions.length - 1) {
        _currentIndex++;
        _scrollController.animateTo(
          _currentIndex * 135.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        _currentIndex = 0;
        _scrollController.animateTo(
          _currentIndex * 135.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('FirebaseAuth.instance.currentUser!.phoneNumber');
    String? number = FirebaseAuth.instance.currentUser == null
        ? ("+91${phoneNumberTextController.text}")
        : (FirebaseAuth.instance.currentUser!.phoneNumber);
    // ignore: avoid_print
    print("${number}HomeScreen");
    print(currentUser!.uid);
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<DocumentSnapshot?>(
        future:
            getUserDataByPhoneNumber(number!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            userData = snapshot.data!.data() as Map<String, dynamic>;
            //  documentID = snapshot.data!.id;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: PRIMARY_COLOR,
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  'SITARE',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
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
                                builder: (context) =>
                                    const WalletRechargeScreen(),
                              ));
                            
                    },
                    icon: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: greyColor,
                    ),
                    label: const Text(
                      '₹0',
                      style: TextStyle(fontSize: 18, color: greyColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
              drawer: HomeScreenDrawerWidget(size: size),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width / 15),
                    child: const Text(
                      "Hi Guru, Welcome",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SlidingPartWidget(scrollController: _scrollController),
                  const SizedBox(height: 10),
                  SecondPartWidget(size: size),
                ],
              ),
            );
          } else {
            return const Text('data');
          }
        });
  }
}
