import 'package:astro_prototype/constants/ui_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FilterSectionSheet extends StatefulWidget {
  const FilterSectionSheet({super.key});

  @override
  State<FilterSectionSheet> createState() => _FilterSectionSheetState();
}

class _FilterSectionSheetState extends State<FilterSectionSheet> {
  int selectedFilterIndex = 0;
  String selectedOption = '';
  final List<String> filterOptions = [
    'Sort by',
    'Skills',
    'Category',
    'Language',
    'Gender',
    'Country'
  ];
  final List<String> sortbyOptions = [
    'Popularity',
    'Experience: High to Low',
    'Experience: Low to High',
    'Orders: High to Low',
    'Orders: Low to High',
    'Price: High to Low',
    'Price: Low to High',
    'Ratings: High to Low',
    'Ratings: Low to High',
  ];
  final List<String> skillsOptions = [
    'Yes',
    'No',
    'Intermediate',
  ];
  final List<String> categoryOptions = [
    'Shoes',
    'Dress',
    'Casual',
  ];
  final List<String> languageOptions = [
    'Tamil',
    'English',
    'Hindi',
  ];
  final List<String> genderOptions = [
    'Male',
    'Female',
    'Others',
  ];
  final List<String> countryOptions = [
    'India  ',
    'Australia',
    'USA',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 25, color: FONT_COLOR, fontWeight: FontWeight.bold),
        ),
        backgroundColor: PRIMARY_COLOR,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: FONT_COLOR,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.77,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
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
                                          child: Row(
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
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Container(
                                                  color:
                                                      selectedFilterIndex == index
                                                          ? Colors.white
                                                          : FONT_COLOR,
                                                  child: ListTile(
                                                    // tileColor:
                                                    //     selectedFilterIndex == index
                                                    //         ? Colors.red
                                                    //         : Colors.black,
                                                    title: Text(
                                                      filterOptions[index],
                                                      style: TextStyle(
                                                          color:
                                                              selectedFilterIndex ==
                                                                      index
                                                                  ? Colors.red
                                                                  : Colors.black),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        selectedFilterIndex =
                                                            index;
                                                      });
                                                      print(filterOptions[index]);
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
                                        height: size.width * 1.3,
                                        width: size.width * 0.7,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: getSelectedOptions().length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return ListTile(
                                              title: Row(
                                                children: [
                                                  Radio(
                                                    value: getSelectedOptions()[
                                                        index],
                                                    groupValue: selectedOption,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedOption =
                                                            value.toString();
                                                        print(selectedOption);
                                                      });
                                                    },
                                                  ),
                                                  Text(getSelectedOptions()[
                                                      index]),
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
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(50)),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       color: Colors.amber,
                                        //       blurRadius: 25.0,
                                        //       offset: Offset(0, 25))
                                        // ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 2),
                                                    child: AutoSizeText(
                                                      'RESET',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: size.width * 0.08,
                                                  width: size.width * 0.25,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 2),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        'APPLY',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(0),
                      ),
                    ),
                  );
                },
                child: Text("Filter"),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
