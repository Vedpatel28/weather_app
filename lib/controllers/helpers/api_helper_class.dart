import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelpers {
  ApiHelpers._();

  static final ApiHelpers apiHelpers = ApiHelpers._();

  getWeatherResponse({String city = 'Surat'}) async {
    String weatherApi =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=cc261512d2cb230b25a9fa3506fb369f";

    http.Response response = await http.get(Uri.parse(weatherApi));

    if (response.statusCode == 200) {
      var weather = jsonDecode(response.body);

      // Map allWeather = weather['main'];

      print("===== $weather =====");

      return weather;
    }
  }
}
