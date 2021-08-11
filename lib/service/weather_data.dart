import 'location.dart';
import 'network.dart';

//https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric

const apiKey = '3befc3fb84c3cafe1bec9d2d1c49e6bd';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5';

class WeatherService {
  static Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Network network = Network(
        '$openWeatherURL/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,daily&appid=$apiKey&units=metric');

    var weatherData = await network.getData();

    return weatherData;
  }

  static Future<dynamic> getCityWeather(Location location) async {
    print(location.latitude);
    print(location.longitude);
    Network network = Network(
        '$openWeatherURL/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,daily&appid=$apiKey&units=metric');

    var weatherData = await network.getData();

    return weatherData;
  }

  static Future<dynamic> getCityNameAndCountry() async {
    Location location = Location();
    await location.getCurrentLocation();

    Network network = Network(
        '$openWeatherURL/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

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

    var weatherData = getCityWeather(location);

    return weatherData;
  }
}
