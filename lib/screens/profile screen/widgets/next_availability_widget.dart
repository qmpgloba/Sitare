
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/next%20availability%20screen/next_availability_screen.dart';

class NextAvailabilityWidget extends StatelessWidget {
  const NextAvailabilityWidget({
    super.key,
    required this.size, required this.astrologer,
  });

  final Size size;
  final AstrologerModel astrologer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  NextAvailabilityScreen(astrologer: astrologer),));
      },
      child: SizedBox(
       width: size.width*.65,
        child: const ListTile(
         leading: Icon(Icons.calendar_month,size: 35,),
         title: AutoSizeText('NEXT AVAILABILITY',maxLines: 1,minFontSize: 12,maxFontSize: 14,style: TextStyle(fontWeight: FontWeight.bold),),
         trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
