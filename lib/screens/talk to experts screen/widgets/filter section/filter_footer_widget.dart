
import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/functions/astrologers/astrologer_details.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/talk_to_experts_screen.dart';
import 'package:sitare/screens/talk%20to%20experts%20screen/widgets/filter%20section/applybutton_widget.dart';

import 'reset_button_widget.dart';

class FilterSectionFooter extends StatefulWidget {
  const FilterSectionFooter({
    super.key, required this.size,
  });
  final Size size;

  @override
  State<FilterSectionFooter> createState() => _FilterSectionFooterState();
}

class _FilterSectionFooterState extends State<FilterSectionFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.width * 0.17,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //      selectedOptions = [];
          //      selectedOptions.addAll(selectedGenders);
          //       selectedExperience = [];
          //       // selectedCountries = [];
          //       // selectedGenders = [];
          //       selectedLanguages = [];
          //       selectedSkills = [];
               
          //     });
          //     // Navigator.pop(context);
             

          //   },
          //   child: const ResetButtonWidget(),
          // ),
          
          GestureDetector(
            onTap: () {
              // streamFilteredAstrologersFromFirestore();
              setState((){fetchFilteredAstrologersFromFirestore();});
              Navigator.pop(context);
              
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TalkToExpertsScreen(),
                  ));
            },
            child: ApplyButtonWidget(
              size: widget.size,
              selectedFilters: selectedOptions,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}