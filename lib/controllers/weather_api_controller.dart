import 'package:flutter/material.dart';
import 'package:weather_app/controllers/helpers/api_helper_class.dart';

class ApiController extends ChangeNotifier {
  Map data = {};

  ApiController() {
    weather();
  }

  weather({String val = 'Surat'}) async {
    data = await ApiHelpers.apiHelpers.getWeatherResponse(city: val) ?? [];
    notifyListeners();
    return 0;
  }
}
