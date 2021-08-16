import 'package:intl/intl.dart';
import 'package:weather_app/models/common/city_base.dart';
import 'package:weather_app/models/location.dart';

class City extends CityBase {
  final String city;
  final String country;
  final String sunrise;
  final String sunset;
  final Location location;

  City(
      {required this.city,
      required this.country,
      required this.sunrise,
      required this.sunset,
      required this.location})
      : super(city: city);

  factory City.fromJson(Map<String, dynamic> jsonData) {
    int epochSunrise = jsonData['sys']['sunrise'];
    int epochSunset = jsonData['sys']['sunset'];
    return City(
      city: jsonData['name'],
      country: jsonData['sys']['country'],
      sunrise: calculateTimeToString(epochSunrise),
      sunset: calculateTimeToString(epochSunset),
      location: Location(
          latitude: jsonData['coord']['lat'],
          longitude: jsonData['coord']['lon']),
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
