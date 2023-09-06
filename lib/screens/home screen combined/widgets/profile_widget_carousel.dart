
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class ProfileViewCarouselHomeWidget extends StatelessWidget {
  const ProfileViewCarouselHomeWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         
          CircleAvatar(
            radius: size.width * .10,
            backgroundImage: const NetworkImage(
                'https://shreepng.com/img/OutSide/Celebrities/SmritiMandhana/cute%20cricketer%20smriti%20mandhana.png'),
          ),
         
          SizedBox(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AutoSizeText(
                  'TAROT READING',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                  maxFontSize: 20,
                  maxLines: 1,
                ),
                const AutoSizeText(
                  'WORKSHOP',
                  // maxLines: 1,
                  maxFontSize: 14,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                const AutoSizeText(
                  'REKHA PONAPPA',
                  // maxLines: 1,
                  maxFontSize: 12,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(
                          255, 6, 37, 114)),
                ),
                const AutoSizeText(
                  'Exp 15 years | ENTRY FEE ₹ 95/-',
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
                        borderRadius:
                            BorderRadius.circular(3)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
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
