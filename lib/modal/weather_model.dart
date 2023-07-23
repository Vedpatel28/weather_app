// ignore_for_file: non_constant_identifier_names

class Weather {
  final double temp;
  final double temp_Min;
  final double temp_Max;
  final String cityName;
  final String countryName;
  final String description;
  final String main;
  final String rain;
  final List<Map<String, dynamic>> weather;
  final double wind;
  final int humidity;
  final double feelsLike;
  final int pressure;

  Weather({
    required this.cityName,
    required this.weather,
    required this.temp_Max,
    required this.temp_Min,
    required this.countryName,
    required this.description,
    required this.main,
    required this.rain,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.temp,
    required this.wind,
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
