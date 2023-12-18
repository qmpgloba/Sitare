
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';

class ProductImageWidget extends StatefulWidget {
   ProductImageWidget({
    super.key,
    required this.imageSliders,
    required CarouselController carouselController,
    required int currentIndex,
  }) : _carouselController = carouselController;

  final List<Widget> imageSliders;
  final CarouselController _carouselController;
   int currentIndex =0;

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imageSliders,
          carouselController: widget._carouselController,
          options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1,
              onPageChanged: (index, reason) {
                setState(() {
                 widget.currentIndex = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () =>
                  widget._carouselController.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(
                            widget.currentIndex == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
