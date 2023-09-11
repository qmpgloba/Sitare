
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AstrologerProfileDetailsWidget extends StatelessWidget {
  const AstrologerProfileDetailsWidget({
    super.key,
    required this.size, required this.name, required this.department, required this.languages, required this.rating, required this.yearsOfExperience, required this.rupees,
  });

  final Size size;
  final String name;
  final String department;
  final String languages;
  final double rating;
  final int yearsOfExperience;
  final int rupees;

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
                  AutoSizeText(
                    department,
                    // maxLines: 1,
                    maxFontSize: 14,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(languages,
                      // maxLines: 1,
                      maxFontSize: 14,
                      style: const TextStyle(
                        fontSize: 14,
                      )),
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
}
