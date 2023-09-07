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
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
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
              padding:  EdgeInsets.fromLTRB(size.width/16, size.width/16, size.width/16, size.width/16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text('Coupon code',style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold,fontSize: 16),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (size.width*.7)-size.width/7,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: whiteColor,
                            filled: true,
                          ),
                        ),
                      ), GestureDetector(
                onTap: () {},
                child: Container(
                  width: size.width*.3,
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
                  SizedBox(height: 10,),
                  Text('Apply another coupon',style: TextStyle(color: redColor,fontWeight: FontWeight.bold,fontSize: 16,decoration: TextDecoration.underline,decorationColor: redColor),),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
           GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.maxFinite,
                  // height: 30,
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(5)),
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
