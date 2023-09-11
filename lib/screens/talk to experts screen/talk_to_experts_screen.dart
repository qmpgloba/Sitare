import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

import 'widgets/talk_to_experts_profile_details_widget.dart';


// ignore: must_be_immutable
class TalkToExpertsScreen extends StatelessWidget {
  TalkToExpertsScreen({super.key});
  num walletAmmount = 200;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          'Talk to Experts',
          style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
            preferredSize: Size(size.width, size.width * .1),
            child: Padding(
              padding: EdgeInsets.all(size.width / 20),
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
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
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.filter_list,
                    size: 30,
                    color: greyColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.search,
                    size: 30,
                    color: greyColor,
                  )
                ],
              ),
            )),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return TalkToExpertsProfileDetailsWidget(size: size);
          },
          itemCount: 6),
    );
  }
}

