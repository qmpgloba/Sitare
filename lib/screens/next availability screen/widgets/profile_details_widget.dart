
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProfileWidgetNextAvailabilityScreen extends StatelessWidget {
  const ProfileWidgetNextAvailabilityScreen({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width / 20),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: size.width * .10,
              backgroundImage: const NetworkImage(
                  'https://shreepng.com/img/OutSide/Celebrities/SmritiMandhana/cute%20cricketer%20smriti%20mandhana.png'),
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Smrithi Mandhana',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxFontSize: 20,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    'Tarot,Numerology',
                    // maxLines: 1,
                    maxFontSize: 12,
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText('English,Hindi,Punjabi',
                      // maxLines: 1,
                      maxFontSize: 12,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
