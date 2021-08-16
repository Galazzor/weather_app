import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/web_api/weather_api_impl.dart';

class GetLocationData {
  static void getLocationData(BuildContext context, String typedCity) async {
    if (typedCity.trim().isEmpty == true) {
      Fluttertoast.showToast(
          msg: "Please type in name of city",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    var weatherService = WeatherApiImpl();
    var cityData = await weatherService.getWeatherByCity(typedCity);
    var weatherData = await weatherService.getOneCall(cityData.location);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            cityData: cityData,
            weatherData: weatherData,
          );
        },
      ),
    );
  }
}
