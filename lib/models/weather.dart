import 'package:weather_app/services/time_calculator.dart';

class Weather {
  bool isSelected = false;
  final num temperature;
  final String time;
  final String weekday;
  final String icon;
  final num precipitation;
  final num humidity;
  final num windSpeed;
  final num pressure;

  Weather(
      {required this.temperature,
      required this.time,
      required this.weekday,
      required this.icon,
      required this.precipitation,
      required this.humidity,
      required this.pressure,
      required this.windSpeed});

  factory Weather.fromJson(Map<String, dynamic> jsonData) {
    num temp = jsonData['temp'];
    num tempPrep = jsonData['pop'];
    int tempEpoch = jsonData['dt'];
    return Weather(
        temperature: temp.toInt(),
        icon: jsonData['weather'][0]['icon'],
        precipitation: tempPrep.toDouble() * 100,
        humidity: jsonData['humidity'],
        windSpeed: jsonData['wind_speed'],
        pressure: jsonData['pressure'],
        time: TimeCalculator.calculateTimeToString(tempEpoch),
        weekday: TimeCalculator.calculateWeekdayToString(tempEpoch));
  }
}
