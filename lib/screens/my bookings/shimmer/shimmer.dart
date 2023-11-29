import 'package:flutter/material.dart';

class MyBookingsShimmer extends StatelessWidget {
  const MyBookingsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(size.width / 25),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: size.width * .07,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: ,
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider()
            ],
          );
        },
      ),
    );
  }
}
