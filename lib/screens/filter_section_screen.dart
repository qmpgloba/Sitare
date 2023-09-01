import 'package:astro_prototype/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class FilterSectionSheet extends StatefulWidget {
  const FilterSectionSheet({super.key});

  @override
  State<FilterSectionSheet> createState() => _FilterSectionSheetState();
}

class _FilterSectionSheetState extends State<FilterSectionSheet> {
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
                    //  backgroundColor: FONT_COLOR,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.08,
                                  right: size.width * 0.08,
                                  top: size.height * 0.02,
                                  bottom: size.height * 0.01,
                                ),
                                color: FONT_COLOR,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                        
                                      ),
                                      shrinkWrap: true,
                                      itemCount: filterOptions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          tileColor: FONT_COLOR,
                                          title: Text(filterOptions[index]),
                                          onTap: () {},
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: sortbyOptions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          color: Colors.white,
                                          child: ListTile(
                                            title: Text(sortbyOptions[index]),
                                            onTap: () {},
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Material(
                                elevation: 50,
                                child: Container(
                                //  width: 200,
                                  height: size.width*0.1,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.amber,
                                          blurRadius: 25.0,
                                          offset: Offset(0, 25))
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(color:  Colors.white,),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(0), // Adjust the value as needed.
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
}
