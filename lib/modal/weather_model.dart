// ignore_for_file: non_constant_identifier_names

class Weather {
  late double? temp;
  late double? temp_Min;
  late double? temp_Max;
  late String? cityName;
  late String? countryName;
  late String? description;
  late String? main;
  late String? rain;
  late List<Map<String, dynamic>>? weather;
  late double? wind;
  late int? humidity;
  late double? feelsLike;
  late int? pressure;

  Weather({
    this.cityName,
    this.weather,
    this.temp_Max,
    this.temp_Min,
    this.countryName,
    this.description,
    this.main,
    this.rain,
    this.feelsLike,
    this.humidity,
    this.pressure,
    this.temp,
    this.wind,
  });

  factory Weather.fromMap({required Map data}) {
    return Weather(
      cityName: data['name'],
      countryName: data['sys']['country'],
      description: data['weather']['description'],
      main: data['weather']['main'],
      rain: data['rain']['1h'],
      feelsLike: data['main']['feels_like'],
      humidity: data['main']['humidity'],
      pressure: data['main']['pressure'],
      temp: data['main']['temp'],
      temp_Min: data['main']['temp_min'],
      temp_Max: data['main']['temp_max'],
      wind: data['wind']['speed'],
      weather: data['weather']['description'],
    );
  }
}
