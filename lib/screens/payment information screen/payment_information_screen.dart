import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

import 'widgets/payment_details_row_widget.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  double totalAmount = 500.0;
  double gstAmount = 90.0;
  double payableAmount = 590.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          'Payment Infromation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: EdgeInsets.all(size.width / 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment details:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PaymentDetailsRowWidget(
                      amount: totalAmount, text: 'Total Amount'),
                  const Divider(
                    thickness: 2,
                    color: greyColor,
                  ),
                  PaymentDetailsRowWidget(amount: gstAmount, text: 'GST @ 18%'),
                  const Divider(
                    thickness: 2,
                    color: greyColor,
                  ),
                  PaymentDetailsRowWidget(
                      amount: payableAmount, text: 'Total Amount'),
                ],
              ),
            ),
          ),
          Container(
            color: Color.fromARGB(255, 4, 41, 72),
            // height: 100,
            child: Padding(
              padding: EdgeInsets.fromLTRB(size.width / 16, size.width / 16,
                  size.width / 16, size.width / 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coupon code',
                    style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (size.width * .7) - size.width / 7,
                        child: TextFormField(
                          decoration: InputDecoration(
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
                          child: Center(
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
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
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
                          // clipBehavior: Clip.hardEdge,
                          // barrierColor: Colors.red,
                          // enableDrag: false,
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
                                          child: Icon(Icons.close)),
                                      ],
                                    ),
                                    Text(
                                      'Coupon code',
                                      style: TextStyle(
                                          color: blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
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
                                            
                                            decoration: InputDecoration(
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
                                            child: Center(
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
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: Text( """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                                                        """,style: TextStyle(color: greyColor),),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
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
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.maxFinite,
                // height: 30,
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Center(
                    child: AutoSizeText(
                      'PAY',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          color: whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
