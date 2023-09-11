
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class CouponCodeWidget extends StatelessWidget {
  const CouponCodeWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 4, 41, 72),
      // height: 100,
      child: Padding(
        padding: EdgeInsets.fromLTRB(size.width / 16, size.width / 16,
            size.width / 16, size.width / 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Coupon code',
              style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: (size.width * .7) - size.width / 7,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: size.width * .3,
                    height: 50,
                    color: redColor,
                    child: const Center(
                      child: AutoSizeText(
                        'Apply',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  anotherCouponBottomSheet(context);
                },
                child: const Text(
                  'Apply another coupon',
                  style: TextStyle(
                      color: redColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: redColor),
                )),
          ],
        ),
      ),
    );
  }

  Future<dynamic> anotherCouponBottomSheet(BuildContext context) {
    return showModalBottomSheet(
                  constraints: BoxConstraints.expand(
                      height: size.height * .6, width: size.width),
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(Icons.close)),
                              ],
                            ),
                            const Text(
                              'Coupon code',
                              style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width:
                                      (size.width * .7) - size.width / 7,
                                  child: TextFormField(
                                    
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Coupon Code',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: greenColor)),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: size.width * .3,
                                    height: 50,
                                    color: redColor,
                                    child: const Center(
                                      child: AutoSizeText(
                                        'Apply',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: size.width,
                              child: const Text( """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                                                """,style: TextStyle(color: greyColor),),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
  }
}
