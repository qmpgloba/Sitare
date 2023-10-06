import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/astrologers/astrologer_details.dart';
import 'package:sitare/model/astrologer_model.dart';

import 'widgets/talk_to_experts_profile_details_widget.dart';

// ignore: must_be_immutable
class TalkToExpertsScreen extends StatelessWidget {
  TalkToExpertsScreen({super.key});
  num walletAmmount = 200;
  int selectedFilterIndex = 0;
  String selectedOption = '';
  
  List<String> getSelectedOptions() {
    switch (selectedFilterIndex) {
      case 0:
        return sortbyOptions;
      case 1:
        return skillsOptions;
      case 2:
        return categoryOptions;
      case 3:
        return languageOptions;
      case 4:
        return genderOptions;
      case 5:
        return countryOptions;

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: const Text(
            'Talk to Experts',
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
              preferredSize: Size(size.width, size.width * .1),
              child: Padding(
                padding: EdgeInsets.all(size.width / 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: whiteColor,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '₹$walletAmmount',
                      style: const TextStyle(color: whiteColor, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(3)),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: AutoSizeText(
                            'RECHARGE',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                color: whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => FilterSectionSheet(),));
                        filterSectionBottomSheet(context, size);
                      },
                      child: const Icon(
                        Icons.filter_list,
                        size: 30,
                        color: greyColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.search,
                      size: 30,
                      color: greyColor,
                    )
                  ],
                ),
              )),
        ),
        body: FutureBuilder<List<AstrologerModel>>(
          future: fetchAstrologerDetailsFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              List<AstrologerModel>? astrologers = snapshot.data;

              return ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: astrologers!.length,
                  itemBuilder: (context, index) =>
                      TalkToExpertsProfileDetailsWidget(
                          size: size, astrologer: astrologers[index]));
            }
          },
        ));
  }

  Future<dynamic> filterSectionBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: size.height*.85),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.76,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        top: size.height * 0.02,
                        bottom: size.height * 0.02,
                      ),
                      color: FONT_COLOR,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Filters",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Clear",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Icon(Icons.close),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                  color: FONT_COLOR,
                                  width: double.maxFinite,
                                  height: size.height * 0.6),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: filterOptions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    color: selectedFilterIndex == index
                                        ? Colors.white
                                        : FONT_COLOR,
                                    child: ListTile(
                                      // tileColor:
                                      //     selectedFilterIndex == index
                                      //         ? Colors.red
                                      //         : Colors.black,
                                      title: Text(
                                        filterOptions[index],
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: selectedFilterIndex == index
                                                ? Colors.red
                                                : Colors.black,fontSize: 15),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedFilterIndex = index;
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: size.height*.6,
                          width: size.width * 0.7,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: getSelectedOptions().length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      value: getSelectedOptions()[index],
                                      groupValue: selectedOption,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOption = value.toString();
                                        });
                                      },
                                    ),
                                    Text(getSelectedOptions()[index],maxLines: 1,style: TextStyle(fontSize: 15),),
                                  ],
                                ),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Material(
                      elevation: 50,
                      child: Container(
                        height: size.width * 0.17,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.amber,
                                //blurRadius: 25.0,
                                offset: Offset(0, 25))
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = '';
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      child: AutoSizeText(
                                        'RESET',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: size.width * 0.08,
                                    width: size.width * 0.25,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      child: Center(
                                        child: AutoSizeText(
                                          'APPLY',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
    );
  }
}
