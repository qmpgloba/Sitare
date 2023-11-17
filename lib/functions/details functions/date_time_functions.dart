import 'package:flutter/material.dart';

TimeOfDay time = TimeOfDay.now();

Future<DateTime?> datePicker(BuildContext context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
}

Future<TimeOfDay?> timePicker(BuildContext context) {
  return showTimePicker(
    context: context,
    initialTime: time,
  );
}
