
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NextAvailabilityWidget extends StatelessWidget {
  const NextAvailabilityWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     width: size.width*.65,
      child: const ListTile(
       leading: Icon(Icons.calendar_month,size: 35,),
       title: AutoSizeText('NEXT AVAILABILITY',maxLines: 1,minFontSize: 12,maxFontSize: 14,style: TextStyle(fontWeight: FontWeight.bold),),
       trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
