import 'package:flutter/foundation.dart';

class Weather {
  final String cityName;
  final double temp;
  final double wind;
  final int humidity;
  final double feelsLike;
  final int pressure;

  Weather({
    required this.cityName,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.temp,
    required this.wind,
  });

  factory Weather.fromMap({required Map data}) {
    return Weather(
      cityName: data['name'],
      feelsLike: data['main']['feels_like'],
      humidity: data['main']['humidity'],
      pressure: data['main']['pressure'],
      temp: data['main']['temp'],
      wind: data['wind']['speed'],
    );
  }
}
