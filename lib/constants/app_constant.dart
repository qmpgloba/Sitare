import 'dart:ui';

import 'package:flutter/cupertino.dart';

bool checkIfNotEmpty(String? value) {
  return value != null && value.isNotEmpty && value != "null";
}

const List<String> GENDERS = ["Male", "Female", "Other"];

