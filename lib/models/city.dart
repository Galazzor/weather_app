import 'package:intl/intl.dart';

class City {
  final String city;
  final String country;
  final String sunrise;
  final String sunset;

  City({this.city, this.country, this.sunrise, this.sunset});

  factory City.fromJson(Map<String, dynamic> jsonData) {
    int epochSunrise = jsonData['sys']['sunrise'];
    int epochSunset = jsonData['sys']['sunset'];
    return City(
      city: jsonData['name'],
      country: jsonData['sys']['country'],
      sunrise: calculateTimeToString(epochSunrise),
      sunset: calculateTimeToString(epochSunset),
    );
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
