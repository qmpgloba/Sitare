
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class ShopSitareContainerWidget extends StatelessWidget {
  const ShopSitareContainerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (size.width/2)+15,
      width: size.width/2-size.width/12,
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('assets/images/walpaper.jpg'),fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        const Text('SHOP SITARE',style: TextStyle(fontSize: 14,color: whiteColor),),
        Container(
          height: size.width/5,
          width: size.width/4,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),

          ),
          child: Image.network('https://www.freepnglogos.com/uploads/scorpion-png/pin-breanna-larson-allen-scorpio-scorpio-scorpio-horoscope-scorpion-15.png'),

        ),
        SizedBox(
          width: size.width/3.3,
          child: const AutoSizeText('Buy gem stones as per your birth star',maxLines: 2,style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
         
        ),
        GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: greenColor,
            borderRadius:
                BorderRadius.circular(3)),
        child: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5, vertical: 2),
          child: AutoSizeText(
            'SHOP NOW',
            maxLines: 1,
            style: TextStyle(
                fontSize: 14,
                color: whiteColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
      ],),
    );
  }
}