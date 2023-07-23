// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/controllers/helpers/api_helper_class.dart';
import 'package:weather_app/modal/history_model.dart';
import 'package:weather_app/modal/like_modal.dart';

class ApiController extends ChangeNotifier {
  Map data = {};

  SharedPreferences sharedPreferences;

  final String _sfTemp = "all_temp";
  final String _sfTemp_Min = "all_temp_Min";
  final String _sfTemp_Max = "all_temp_Max";

  final String _sfSearch = "all_search";

  List<String> _allTemp = [];
  List<String> _allTempMax = [];
  List<String> _allTempMin = [];

  List<String> _allSearch = [];

  List<LikedModal> likedTemp = [];
  List<HistoryModal> historySearch = [];

  List<LikedModal> get getWeather {
    _allTemp = sharedPreferences.getStringList(_sfTemp) ?? [];
    _allTempMin = sharedPreferences.getStringList(_sfTemp_Min) ?? [];
    _allTempMax = sharedPreferences.getStringList(_sfTemp_Max) ?? [];

    likedTemp = List.generate(
      _allTemp.length,
      (index) => LikedModal(
        temp: _allTemp[index] as double,
        temp_Min: _allTempMin[index] as double,
        temp_Max: _allTempMax[index] as double,
      ),
    );
    return likedTemp;
  }

  List<HistoryModal> get getSearchHistory {
    _allSearch = sharedPreferences.getStringList(_sfSearch) ?? [];

    historySearch = List.generate(
      _allSearch.length,
      (index) => HistoryModal(
        search: _allSearch[index],
      ),
    );
    return historySearch;
  }

  void addLikedTemp({
    required String temp,
    required String tempMin,
    required String tempMax,
  }) {
    _allTemp = sharedPreferences.getStringList(_allTemp as String) ?? [];
    _allTempMax = sharedPreferences.getStringList(_allTempMax as String) ?? [];
    _allTempMin = sharedPreferences.getStringList(_allTempMin as String) ?? [];

    _allTemp.add(temp);
    _allTempMax.add(tempMax);
    _allTempMin.add(tempMin);

    sharedPreferences.setStringList(_sfTemp, _allTemp);
    sharedPreferences.setStringList(_sfTemp_Min, _allTempMin);
    sharedPreferences.setStringList(_sfTemp_Max, _allTempMax);
  }

  void addSearch({required String search}) {
    _allSearch = sharedPreferences.getStringList(_allSearch as String) ?? [];

    _allSearch.add(search);

    sharedPreferences.setStringList(_sfSearch, _allSearch);
  }

  ApiController({required this.sharedPreferences}) {
    weather();
  }

  List<String> listOfHistory = [];

  weather({String val = 'Surat'}) async {
    data = await ApiHelpers.apiHelpers.getWeatherResponse(city: val) ?? [];
    listOfHistory.add(val);
    notifyListeners();
    return 0;
  }

  addHistory({required String search}) {
    listOfHistory.add(search);
    notifyListeners();
  }
}
