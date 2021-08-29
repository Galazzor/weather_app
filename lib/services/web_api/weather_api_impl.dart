import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';

import 'weather_api.dart';

//TODO Move to .env
const apiKey = '3befc3fb84c3cafe1bec9d2d1c49e6bd';
const openWeatherURL = 'api.openweathermap.org';

class WeatherApiImpl extends WeatherApi {
  WeatherApiImpl() : super(openWeatherURL, apiKey);

  Future<List<Weather>> getOneCall(Location? location) async {
    var weatherData;
    try {
      weatherData = await getJson('onecall', {
        "lat": location!.latitude.toString(),
        "lon": location.longitude.toString(),
        "exclude": "minutely,daily",
        "units": "metric"
      });
    } catch (e) {
      print('Wrong Location');
    }

    List<Weather> weathers = <Weather>[];

    for (int i = 0; i <= 24; i++) {
      weathers.add(Weather.fromJson(weatherData['hourly'][i]));
    }

    return weathers;
  }

  Future<City> getWeatherByLocation(Location location) async {
    var cityData;
    try {
      cityData = await getJson('weather', {
        "lat": location.latitude.toString(),
        "lon": location.longitude.toString(),
        "units": "metric"
      });
    } catch (e) {
      print('Wrong Location');
    }

    return City.fromJson(cityData);
  }

  Future<City> getWeatherByCity(String city) async {
    var cityData;
    try {
      cityData = await getJson('weather', {"q": city, "units": "metric"});
    } catch (e) {
      throw e;
    }
    return City.fromJson(cityData);
  }
}
