import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/service/chat_service.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/widgets/shimmer/shimmer.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/widgets/talk_to_experts_profile_details_widget.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';
import 'package:sitare/screens/widgets/wallet_amount.dart';

// ignore: must_be_immutable
class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});
  num walletAmmount = 200;
  final ChatService _chatService = ChatService();

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
                    builder: (context) => const WalletRechargeScreen(),
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
                    const WalletAmount(color: whiteColor, fontSize: 16),
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
      body: SafeArea(
        child: FutureBuilder(
          future: _chatService.fetchOtherParticipants(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: TalkToExpertShimmer());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (snapshot.hasData) {
                List<AstrologerModel> astrologers = snapshot.data!;
                return ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: astrologers.length,
                  itemBuilder: (context, index) =>
                      TalkToExpertsProfileDetailsWidget(
                    size: size,
                    astrologer: astrologers[index],
                  ),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            }
          },
        ),
      ),
    );
  }
}
