import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/shopping%20cart/widgets/counter_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  final Size size;
  final String image;
  final String title;
  final String description;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.width * 0.05,
          bottom: size.width * 0.05,
        ),
        child: SizedBox(
          height: size.height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                image,
                width: size.width * 0.3,
                height: size.height * 0.25,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: AutoSizeText(
                      title,
                      maxFontSize: 18,
                      maxLines: 1,
                      minFontSize: 14,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: size.width * 0.3,
                    child: AutoSizeText(
                      description, maxFontSize: 14, textScaleFactor: 1,
                      maxLines: 2,
                      minFontSize: 10,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.12,
                            child:  AutoSizeText(
                              '₹$price',
                              maxLines: 1,
                              maxFontSize: 12,
                              minFontSize: 10,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: size.width * 0.08,
                                  child: CounterButton(size: size),
                                ),
                                SizedBox(
                                  width: size.width * 0.1,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete_rounded,
                                      color: greyColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}