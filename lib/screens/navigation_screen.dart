import 'package:flutter/material.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:sitare/screens/login%20email%20screen/login_email_screen.dart';
import 'package:sitare/screens/order%20history%20screen/order_history_screen.dart';
import 'package:sitare/screens/otp%20page/otp_screen.dart';
import 'package:sitare/screens/payment%20information%20screen/payment_information_screen.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/talk_to_experts_screen.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';
import 'package:sitare/screens/welcome%20page/welcome_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sitare'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavigationButton(
                screen: CreateAccountScreen(),
                text: 'Create account screen',
              ),
              //const NavigationButton(screen: EnterDetailsScreen(),text: 'Enter details screen',), //was getting error cause we are passing values from screen to screen
              // const NavigationButton(
              //   screen: FilterSectionSheet(),
              //   text: 'Filter section',
              // ),
              const NavigationButton(
                screen: HomeScreen(),
                text: 'Home screen',
              ),
              const NavigationButton(
                screen: LoginEmailScreen(),
                text: 'Login with email',
              ),
              // const NavigationButton(
              //   screen: NextAvailabilityScreen(),
              //   text: 'next availability screen',
              // ),
              NavigationButton(
                screen: OrderHistoryScreen(),
                text: 'Order history',
              ),
              NavigationButton(
                screen: OTPScreen(),
                text: 'otp screen',
              ),
              NavigationButton(
                screen: PaymentScreen(),
                text: 'Payment information screen',
              ),
              // NavigationButton(
              //   // screen: ProfileScreen(),
              //   text: 'Profile screen',
              // ),
              const NavigationButton(
                screen: TalkToExpertsScreen(),
                text: 'Talk to experts screen',
              ),
              const NavigationButton(
                screen: WalletRechargeScreen(),
                text: 'Wallet recharge',
              ),
              NavigationButton(
                screen: WelcomeScreen(),
                text: 'Welcome screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.screen,
    required this.text,
  });
  final Widget screen;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => screen,
          ));
        },
        child: Text(text));
  }
}
