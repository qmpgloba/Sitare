import 'package:flutter/material.dart';
import 'package:sitare/constants/app_constants.dart';
import 'package:sitare/constants/ui_constants.dart';

class FilterSectionsWidget extends StatelessWidget {
  const FilterSectionsWidget({
    super.key,
    required this.index,
    required this.selectedIndex, required this.onTap,
    
  });
  final int index;
  final int selectedIndex;
  final Function(int index) onTap;
  

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: selectedIndex == index ? Colors.white : greyColor,
      child: ListTile(
        // tileColor:
        //     selectedFilterIndex == index
        //         ? Colors.red
        //         : Colors.black,
        title: Text(
          filterOptions[index],
          maxLines: 1,
          style: TextStyle(
              color: selectedIndex == index
                  ? Colors.red
                  : blackColor,
              fontSize: 15),
        ),
        onTap: () {
        onTap(index);
        },
      ),
    );
  }
}
