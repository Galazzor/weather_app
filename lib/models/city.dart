import 'package:weather_app/models/common/city_base.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/services/time_calculator.dart';

class City extends CityBase {
  final String cityName;
  final String country;
  final String sunrise;
  final String sunset;
  final Location location;

  City(
      {required this.cityName,
      required this.country,
      required this.sunrise,
      required this.sunset,
      required this.location})
      : super(cityName: cityName);

  factory City.fromJson(Map<String, dynamic> jsonData) {
    int epochSunrise = jsonData['sys']['sunrise'];
    int epochSunset = jsonData['sys']['sunset'];
    return City(
      cityName: jsonData['name'],
      country: jsonData['sys']['country'],
      sunrise: TimeCalculator.calculateTimeToString(epochSunrise),
      sunset: TimeCalculator.calculateTimeToString(epochSunset),
      location: Location(
          latitude: jsonData['coord']['lat'],
          longitude: jsonData['coord']['lon']),
    );
  }
}
