import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';

class TimeSlotsWidget extends StatefulWidget {
  TimeSlotsWidget({
    super.key,
    required this.dateTime,
    required this.timeSlots,
    required this.selected,
    required this.onSelectionChanged,
  });

  // final List selectedIndex;
  // final List selected;
  final DateTime dateTime;
  final List timeSlots;
  int? selected;
  final void Function(int?) onSelectionChanged;

  @override
  State<TimeSlotsWidget> createState() => _TimeSlotsWidgetState();
}

class _TimeSlotsWidgetState extends State<TimeSlotsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
        itemCount: widget.timeSlots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // if (widget.selectedIndex.contains(index)) {
              //   widget.selected.remove(widget.timeSlots[index]);
              //   widget.selectedIndex.remove(index);
              // } else {
              //   widget.selected.add(widget.timeSlots[index]);
              //   widget.selectedIndex.add(index);
              // }
              widget.onSelectionChanged(index);
              widget.selected = index;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Container(
                // width: 30,
                height: 5,

                decoration: BoxDecoration(
                  color: widget.selected == index ? blackColor : whiteColor,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    widget.timeSlots[index],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: widget.selected == index
                            ? whiteColor
                            : Colors.black),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
