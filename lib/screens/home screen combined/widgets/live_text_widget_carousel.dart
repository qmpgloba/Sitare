
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class LiveTextWidgetCarousel extends StatelessWidget {
  const LiveTextWidgetCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(5),
                        color: redColor,
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Transform.rotate(
                        angle: 45 *
                            3.14159265359 /
                            180, // 45 degrees in radians
                        child: const Icon(
                          Icons.wifi,
                          size: 18,
                          color: Colors.red,
                        ),
                      ))
                ],
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}