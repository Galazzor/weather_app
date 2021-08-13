import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';

import '../models/location.dart';
import 'api_service.dart';

//https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric,

const apiKey = '3befc3fb84c3cafe1bec9d2d1c49e6bd';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5';

class WeatherService extends ApiService {
  WeatherService() : super(openWeatherURL);

  Future<List<Weather>> getOneCall(Location location) async {
    var weatherData = await getJson(
        'onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,daily&appid=$apiKey&units=metric');

    List<Weather> weathers = <Weather>[];
    for (int i = 0; i <= 24; i++) {
      weathers.add(Weather.fromJson(weatherData['hourly'][i]));
    }
    return weathers;
  }

  Future<City> getWeather(Location location) async {
    var cityData = await getJson(
        'weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    return City.fromJson(cityData);
  }

  Future<Location> getWeatherCity(String city, {bool diff = false}) async {
    var locationData =
        await getJson('weather?q=$city&appid=$apiKey&units=metric');

    return Location.fromJson(locationData, diff: diff);
  }
}

/*
class WeatherService {

  static Future<dynamic> get(Location location) async {
    Network network = Network(
        '$openWeatherURL/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,daily&appid=$apiKey&units=metric');
  }

  static Future<dynamic> getCountryAndCity(String cityName) async {
    Network network = Network(
        '$openWeatherURL/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await network.getData();

    return weatherData;
  }

  static Future<dynamic> getCityData(String cityName) async {
    Location location = Location();

    Network network = Network(
        '$openWeatherURL/weather?q=$cityName&appid=$apiKey&units=metric');

    var tempWeatherData = await network.getData();

    location.latitude = tempWeatherData['coord']['lat'];
    location.longitude = tempWeatherData['coord']['lon'];

    var weatherData = get(location);

    return weatherData;
  }
}
*/
