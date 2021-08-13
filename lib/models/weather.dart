import 'package:intl/intl.dart';

class Weather {
  bool isSelected = false;
  final num temperature;
  final String time;
  final String weekday;
  final String icon;
  final num precipitation;

  Weather(
      {this.temperature,
      this.time,
      this.weekday,
      this.icon,
      this.precipitation});

  factory Weather.fromJson(Map<String, dynamic> jsonData) {
    num temp = jsonData['temp'];
    num tempPrep = jsonData['pop'];
    int tempEpoch = jsonData['dt'];
    return Weather(
        temperature: temp.toInt(),
        icon: jsonData['weather'][0]['icon'],
        precipitation: tempPrep.toDouble() * 100,
        time: calculateTimeToString(tempEpoch),
        weekday: calculateWeekdayToString(tempEpoch));
  }

  static String calculateWeekdayToString(int epoch) {
    DateTime temp = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('EEEE, d MMM').format(temp);
  }

  static String calculateTimeToString(int epoch) {
    DateTime temp = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('jm').format(temp);
  }
}
