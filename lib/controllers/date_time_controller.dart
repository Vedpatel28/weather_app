// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class dateTimeController extends ChangeNotifier {
  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'june',
    'july',
    'August',
    'september',
    'October',
    'november',
    'december',
  ];

  int mon = DateTime.now().month;
  int date = DateTime.now().day;
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;
}
