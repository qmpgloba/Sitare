import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/astrologers/astrologer_details.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/widgets/filter%20section/filter_section_header_widget.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/widgets/shimmer/shimmer.dart';
import 'package:sitare/screens/wallet%20recharge%20screen/wallet_recharge_screen.dart';

import 'widgets/filter section/filter_footer_widget.dart';
import 'widgets/talk_to_experts_profile_details_widget.dart';

// ignore: must_be_immutable
class TalkToExpertsScreen extends StatefulWidget {
  const TalkToExpertsScreen({super.key});

  @override
  State<TalkToExpertsScreen> createState() => _TalkToExpertsScreenState();
}

class _TalkToExpertsScreenState extends State<TalkToExpertsScreen> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  num walletAmmount = 200;

  int selectedFilterIndex = 0;
  bool _isVisible = false;

  List<String> getSelectedOptions() {
    switch (selectedFilterIndex) {
      case 0:
        return skillsOptions;
      case 1:
        return languageOptions;
      case 2:
        return experienceOptions;
      case 3:
        return genderOptions;
      // case 4:
      //   return countryOptions;

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
          preferredSize: _isVisible == true
              ? Size(size.width, size.width * .28)
              : Size(size.width, size.width * .1),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(size.width / 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WalletRechargeScreen(),
                        ));
                      },
                      child: const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: whiteColor,
                        size: 25,
                      ),
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WalletRechargeScreen(),
                        ));
                      },
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => FilterSectionSheet(),));
                        filterSectionBottomSheet(size, context);
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      child: const Icon(
                        Icons.search,
                        size: 30,
                        color: greyColor,
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: Container(
                  color: whiteColor,
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _searchTextController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      style: const TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: FONT_COLOR),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<AstrologerModel>>(
        future: fetchFilteredAstrologersFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const TalkToExpertShimmer();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            List<AstrologerModel>? astrologers = snapshot.data;
            List<AstrologerModel> filteredAstrologers = [];

            if (_searchTextController.text.isNotEmpty) {
              filteredAstrologers = astrologers!
                  .where((astrologer) => astrologer.fullName
                      .toLowerCase()
                      .contains(_searchTextController.text.toLowerCase()))
                  .toList();
            } else {
              filteredAstrologers = astrologers!;
            }

            return filteredAstrologers.isEmpty
                ? const Center(
                    child: Text('No Astrologers Found'),
                  )
                : ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: filteredAstrologers.length,
                    itemBuilder: (context, index) =>
                        TalkToExpertsProfileDetailsWidget(
                      size: size,
                      astrologer: filteredAstrologers[index],
                    ),
                  );
          }
        },
      ),
    );
  }

  Future<dynamic> filterSectionBottomSheet(
    Size size,
    BuildContext context,
  ) {
    return showModalBottomSheet(
      constraints:
          BoxConstraints.expand(height: size.height * .7, width: size.width),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                FilterSectionHeader(size: size),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                              color: FONT_COLOR,
                              width: double.maxFinite,
                              height: size.height * 0.55),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: filterOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: selectedFilterIndex == index
                                    ? Colors.white
                                    : FONT_COLOR,
                                child: ListTile(
                                  title: Text(
                                    filterOptions[index],
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: selectedFilterIndex == index
                                            ? Colors.red
                                            : const Color.fromRGBO(0, 0, 0, 1),
                                        fontSize: 14),
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
                      height: size.height * .55,
                      width: size.width * 0.65,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: getSelectedOptions().length,
                        itemBuilder: (BuildContext context, int index) {
                          final option = getSelectedOptions()[index];
                          final isSelected = selectedOptions.contains(option);
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          selectedOptions.add(option);
                                          if (selectedFilterIndex == 0) {
                                            selectedSkills.add(option);
                                          } else if (selectedFilterIndex == 1) {
                                            selectedLanguages.add(option);
                                          } else if (selectedFilterIndex == 2) {
                                            selectedExperience.add(option);
                                          } else if (selectedFilterIndex == 3) {
                                            selectedGenders.add(option);
                                          }
                                          // else if (selectedFilterIndex == 4) {
                                          //   selectedCountries.add(option);
                                          // }
                                        } else {
                                          if (selectedSkills.length != 1 &&
                                              selectedFilterIndex == 0) {
                                            selectedOptions.remove(option);
                                            selectedSkills.remove(option);
                                          }
                                          if (selectedLanguages.length != 1 &&
                                              selectedFilterIndex == 1) {
                                            selectedOptions.remove(option);
                                            selectedLanguages.remove(option);
                                          }
                                          if (selectedExperience.length != 1 &&
                                              selectedFilterIndex == 2) {
                                            selectedOptions.remove(option);
                                            selectedExperience.remove(option);
                                          }
                                          if (selectedGenders.length != 1 &&
                                              selectedFilterIndex == 3) {
                                            selectedOptions.remove(option);
                                            selectedGenders.remove(option);
                                          }
                                        }
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  getSelectedOptions()[index],
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 15),
                                ),
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
                  child: FilterSectionFooter(size: size),
                )
              ],
            );
          },
        );
      },
    );
  }
}
