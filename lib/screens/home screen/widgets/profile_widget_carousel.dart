import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/model/astrologer_model.dart';

import '../../../constants/ui_constants.dart';

class ProfileViewCarouselHomeWidget extends StatelessWidget {
  const ProfileViewCarouselHomeWidget({
    super.key,
    required this.size, required this.astrologer,
  });
  final Size size;
  final AstrologerModel astrologer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: size.width * .10,
            backgroundImage:  NetworkImage(
                astrologer.profilePic),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 AutoSizeText(
                  astrologer.skills.take(1).join(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  maxFontSize: 18,
                  maxLines: 1,
                ),
                // const AutoSizeText(
                //   'WORKSHOP',
                //   // maxLines: 1,
                //   maxFontSize: 14,
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                // ),
                 AutoSizeText(
                  astrologer.fullName,
                  // maxLines: 1,
                  maxFontSize: 12,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 6, 37, 114)),
                ),
                 AutoSizeText(
                   'Exp ${astrologer.experienceYears} years | ${astrologer.rpm == '0.0'? 'Free' : "₹${astrologer.rpm}/min"}',
                  maxLines: 1,
                  minFontSize: 8,
                  maxFontSize: 10,
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(3)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: AutoSizeText(
                        'BOOK NOW',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14,
                            color: whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 30,
            color: greyColor,
          )
        ],
      ),
    );
  }
}
