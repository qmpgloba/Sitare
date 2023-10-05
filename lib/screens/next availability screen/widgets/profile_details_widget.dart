
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/model/astrologer_model.dart';

class ProfileWidgetNextAvailabilityScreen extends StatelessWidget {
  const ProfileWidgetNextAvailabilityScreen({
    super.key,
    required this.size, required this.astrologer,
  });

  final Size size;
  final AstrologerModel astrologer;

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
              backgroundImage:  NetworkImage(
                  astrologer.profilePic),
            ),
            const SizedBox(
              width: 10,
            ),
             SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    astrologer.fullName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxFontSize: 20,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    astrologer.skills.take(3).join(', '),
                    // maxLines: 1,
                    maxFontSize: 12,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(astrologer.languages.take(3).join(', '),
                      // maxLines: 1,
                      maxFontSize: 12,
                      style: const TextStyle(
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
