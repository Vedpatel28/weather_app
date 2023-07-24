// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/controllers/helpers/api_helper_class.dart';
import 'package:weather_app/modal/history_model.dart';

class ApiController extends ChangeNotifier {
  Map data = {};

  SharedPreferences sharedPreferences;

  List likedTemp = [];
  List likedName = [];
  List likedTimeMin = [];
  List likedTimeHou = [];
  List<HistoryModal> historySearch = [];

  List<String> listOfHistory = [];

  weather({String val = 'Surat'}) async {
    data = await ApiHelpers.apiHelpers.getWeatherResponse(city: val) ?? [];
    listOfHistory.add(val);
    notifyListeners();
    return 0;
  }

  ApiController({required this.sharedPreferences}) {
    weather(val: "Surat");
    notifyListeners();
  }

  Saved({required double temp, required String name}) {
    likedTemp.add(temp);
    likedName.add(name);
    notifyListeners();
  }
}
