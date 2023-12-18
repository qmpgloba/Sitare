import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/product%20description%20screen/widgets/product_details_widget.dart';
import 'package:sitare/screens/product%20description%20screen/widgets/product_image_widget.dart';
import 'package:sitare/screens/shopping%20cart/cart.dart';
import 'package:sitare/screens/widgets/wallet_amount.dart';

// ignore: must_be_immutable
class ProductDescriptionScreen extends StatefulWidget {
  const ProductDescriptionScreen({
    super.key,
  });

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  num walletBalnce = 0;
  final int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  final List<Widget> imageSliders = imageList
      .map((item) => Container(
          margin: const EdgeInsets.all(10),
          child: Image.network(
            item,
            fit: BoxFit.fill,
          )))
      .toList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: whiteColor),
          backgroundColor: PRIMARY_COLOR,
          title: const Text(
            'Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
          ),
          centerTitle: true,
          actions: [
            ElevatedButton.icon(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
                backgroundColor: MaterialStatePropertyAll(PRIMARY_COLOR),
                elevation: MaterialStatePropertyAll(0),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.account_balance_wallet_outlined,
                color: greyColor,
              ),
              label: const WalletAmount(color: greyColor, fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShoppingCart()),
                );
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: greyColor,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProductImageWidget(
                    imageSliders: imageSliders,
                    carouselController: _carouselController,
                    currentIndex: _currentIndex),
                ProductDetailsWidget(
                    size: size,
                    title: 'Black Fish Evil Eye',
                    subTitle: 'Handmade 925 sterling silver necklace',
                    rupees: '2095'),
                const Column(
                  children: [
                    TabBar(
                      indicatorColor: redColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: 'Details',
                        ),
                        Tab(
                          text: 'shipping',
                        ),
                        Tab(
                          text: 'Reviews',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * .7,
                  child: Padding(
                    padding: EdgeInsets.all(size.width / 16),
                    child: const TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SingleChildScrollView(
                          child: SizedBox(
                            // height: 200,
                            child: Text(
                              '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum''',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Text(
                          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum''',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 200,
                          child: Text(
                            '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum''',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(3)),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: AutoSizeText(
                            'ADD TO CART',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 10,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'CONTINUE SHOPPING (home)',
                      style: TextStyle(color: blackColor, fontSize: 12),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
