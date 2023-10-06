
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sitare/model/astrologer_model.dart';

class AstrologerProfileDetailsWidget extends StatelessWidget {
  const AstrologerProfileDetailsWidget({
    super.key,
    required this.size, required this.name, required this.department, required this.languages, required this.rating, required this.yearsOfExperience, required this.rupees, required this.astrologer,
  });

  final Size size;
  final String name;
  final String department;
  final String languages;
  final double rating;
  final int yearsOfExperience;
  final int rupees;
  final AstrologerModel astrologer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width/2.2,
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    name,
                    // maxLines: 1,
                    maxFontSize: 16,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      commentBottomSheet(size, context,'Skills',astrologer.skills);
                    },
                    child: AutoSizeText(
                      department,
                      // maxLines: 1,
                      maxFontSize: 14,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                     onTap: () {
                      commentBottomSheet(size, context,'Languages Known',astrologer.languages);
                    },
                    child: AutoSizeText(languages,
                        // maxLines: 1,
                        maxFontSize: 14,
                        style: const TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
            ),const Spacer(),
            SizedBox(
              width: size.width/2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RatingBar.builder(
                    initialRating: rating,
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
                    },
                  ),
                   AutoSizeText('Exp $yearsOfExperience years | ₹ $rupees/min',maxLines: 1,maxFontSize: 12,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
Future<dynamic> commentBottomSheet(Size size, BuildContext context, String text,List list
   ) {
    
  return showModalBottomSheet(
    constraints:
        BoxConstraints.expand(height: size.height * .3, width: size.width),
    isScrollControlled: true, 
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
   
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(size.width / 16),
        child: Column(
          children: [
             Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
            const Divider(
              // height: 3,
              color: Colors.white,
            ),
            Expanded(
                child: ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) => Text(list[index],))),
            SizedBox(
              height: size.width / 20,
            ),
            // SizedBox(
            //   height: size.width * .12,
            //   child: TextField(
            //     controller: commentController,
            //     decoration: InputDecoration(
            //         suffixIcon: const Icon(Icons.send),
            //         hintText: 'Add a comment...',
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10))),
            //   ),
            // )
          ],
        ),
      );
    },
  );
}

}
