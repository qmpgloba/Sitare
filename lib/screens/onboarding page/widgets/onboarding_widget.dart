import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/create%20account%20page/cerate_account_screen.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.text,
    required this.color, required this.isVisible,
  });
  final String text;
  final Color color;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: \,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SITARE',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
                ),
                Visibility(
                  visible: isVisible,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>const CreateAccountScreen(),
                            ),
                            (route) => false);
                      },
                      child: const Text('Skip',style: TextStyle(color: whiteColor),)),
                )
              ],
            ),
            Expanded(
                child: Center(
                    child: Text(
              text,
              style: const TextStyle(fontSize: 35, color: whiteColor),
            ))),
           
          ],
        ),
      ),
    );
  }
}
