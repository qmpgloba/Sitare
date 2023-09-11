import 'package:flutter/material.dart';

class BuyNowHomeScreenWidget extends StatelessWidget {
  const BuyNowHomeScreenWidget({
    super.key,
    required this.size,
  });
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Center the content within the stack
      children: [
        Container(
          height: 140,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/astrology.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 20,
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Energized rosary wearing & chanting mantras",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Center(
                      child: Text(
                    "BUY NOW",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
