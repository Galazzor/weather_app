import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';

abstract class WeatherApi {
  final String baseUrl;
  final String apiKey;
  final Map<String, String> _headers = {'Accept': 'application/json'};

  WeatherApi(this.baseUrl, this.apiKey);

  Future<Map<String, dynamic>> getJson(String path,
      [Map<String, dynamic>? queryParameters]) async {
    queryParameters?.putIfAbsent("appid", () => this.apiKey);
    final uri = Uri.https(this.baseUrl, "data/2.5/" + path, queryParameters);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
    return json.decode(response.body);
  }

  Future<List<Weather>> getOneCall(Location location);
  Future<City> getWeatherByLocation(Location location);
  Future<City> getWeatherByCity(String city);
}
