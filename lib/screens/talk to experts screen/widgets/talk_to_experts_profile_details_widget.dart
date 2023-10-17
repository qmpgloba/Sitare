import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sitare/functions/contact%20functions/contact_functions.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/chat_screen.dart';
import 'package:sitare/screens/profile%20screen/profile_screen.dart';

import '../../../constants/ui_constants.dart';
import 'contact_icons_widget.dart';

class TalkToExpertsProfileDetailsWidget extends StatelessWidget {
  const TalkToExpertsProfileDetailsWidget({
    super.key,
    required this.size,
    required this.astrologer,
  });

  final Size size;
  final AstrologerModel astrologer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreen(astrologer: astrologer),
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(size.width / 20),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: size.width * .12,
                    backgroundImage: NetworkImage(astrologer.profilePic),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          astrologer.fullName,
                          style: const TextStyle(fontSize: 16),
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
                          onRatingUpdate: (rating) {},
                        ),
                        AutoSizeText(
                          astrologer.skills.take(2).join(','),
                          // maxLines: 1,
                          maxFontSize: 14,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(astrologer.languages.take(2).join(','),
                            // maxLines: 1,
                            maxFontSize: 14,
                            style: const TextStyle(
                              fontSize: 14,
                            )),
                        AutoSizeText(
                          'Exp ${astrologer.experienceYears} years | ₹ 95/min',
                          maxLines: 1,
                          maxFontSize: 13,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(astrologer: astrologer),));
                        },
                        child: const ContactIconsTalkToExpertsScreen(
                            icon: Icons.chat_outlined, text: 'Chat'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          // print("ckb");
                          sendNotification(astrologer.fcmToken);
                        },
                        child: const ContactIconsTalkToExpertsScreen(
                            icon: Icons.call_outlined, text: 'Call'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          launchWhatsAppUri(astrologer.phoneNumber);
                        },
                        child: const ContactIconsTalkToExpertsScreen(
                            icon: Icons.video_call_outlined, text: 'Video'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const LinearProgressIndicator(
                value: .70,
                color: greenColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
