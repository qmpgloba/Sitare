
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants/ui_constants.dart';
import 'contact_icons_widget.dart';

class TalkToExpertsProfileDetailsWidget extends StatelessWidget {
  const TalkToExpertsProfileDetailsWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width / 20),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: size.width * .12,
                  backgroundImage: const NetworkImage(
                      'https://shreepng.com/img/OutSide/Celebrities/SmritiMandhana/cute%20cricketer%20smriti%20mandhana.png'),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AutoSizeText(
                        'Smrithi Mandhana',
                        style: TextStyle(fontSize: 14),
                        maxFontSize: 16,
                        maxLines: 1,
                      ),
                      RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const AutoSizeText(
                        'Tarot,Numerology',
                        // maxLines: 1,
                        maxFontSize: 12,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const AutoSizeText('English,Hindi,Punjabi',
                          // maxLines: 1,
                          maxFontSize: 12,
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      const AutoSizeText(
                        'Exp 15 years | ₹ 95/min',
                        maxLines: 1,
                        maxFontSize: 12,
                      )
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactIconsTalkToExpertsScreen(
                        icon: Icons.chat_outlined, text: 'Chat'),
                    SizedBox(
                      height: 5,
                    ),
                    ContactIconsTalkToExpertsScreen(
                        icon: Icons.call_outlined, text: 'Call'),
                    SizedBox(
                      height: 5,
                    ),
                    ContactIconsTalkToExpertsScreen(
                        icon: Icons.video_call_outlined, text: 'Video'),
                  ],
                ),
               
              ],
            ),
            SizedBox(height: 10,),
             LinearProgressIndicator(
              value: .70,
              color: greenColor,
             )
          ],
        ),

      ),
    );
  }
}