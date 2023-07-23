import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/controllers/helpers/api_helper_class.dart';
import 'package:weather_app/modal/weather_model.dart';

class ApiController extends ChangeNotifier {
  Map data = {};

  SharedPreferences preferences;

  final String _sfTemp = "all_temp";
  final String _sfHigTemp = "all_higTemp";
  final String _sfLowTemp = "all_LowTemp";

  List<String> _allTemp = [];
  List<String> _allHigTemp = [];
  List<String> _allLowTemp = [];

  List<Weather> allTemp = [];

  get getAllTemp {
    _allTemp = preferences.getStringList(_sfTemp) ?? [];
    _allHigTemp = preferences.getStringList(_sfHigTemp) ?? [];
    _allLowTemp = preferences.getStringList(_sfLowTemp) ?? [];

    allTemp = List.generate(
      _allTemp.length,
      (index) => Weather(
        cityName: cityName,
        weather: weather,
        temp_Max: _allHigTemp[index] as double,
        temp_Min: _allLowTemp[index] as double,
        countryName: countryName,
        feelsLike: feelsLike,
        humidity: humidity,
        pressure: pressure,
        temp: _allTemp[index] as double,
        wind: wind,
      ),
    );
    return allTemp;
  }

  ApiController({required this.preferences}) {
    weather();
  }

  weather({String val = 'Surat'}) async {
    data = await ApiHelpers.apiHelpers.getWeatherResponse(city: val) ?? [];
    notifyListeners();
    return 0;
  }
}
