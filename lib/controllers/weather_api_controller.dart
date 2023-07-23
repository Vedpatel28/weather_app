import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/controllers/helpers/api_helper_class.dart';

class ApiController extends ChangeNotifier {
  Map data = {};

  SharedPreferences sharedPreferences;

  List likePage = [];
  List historyPage = [];

  ApiController({required this.sharedPreferences}) {
    weather();
  }

  weather({String val = 'Surat'}) async {
    data = await ApiHelpers.apiHelpers.getWeatherResponse(city: val) ?? [];
    notifyListeners();
    return 0;
  }
}
