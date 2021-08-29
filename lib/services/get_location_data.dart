import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/web_api/weather_api_impl.dart';
import 'package:weather_app/widgets/toast_message.dart';

class GetLocationData {
  static void getLocationData(BuildContext context, String typedCity) async {
    if (typedCity.trim().isEmpty == true) {
      ToastMessage.showMessage(message: 'Please type in name of city');
      return;
    }
    try {
      var weatherService = WeatherApiImpl();
      City cityData = await weatherService.getWeatherByCity(typedCity);
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
    } catch (e) {
      ToastMessage.showMessage(message: 'City that you typed does not exist');
      return;
    }
  }
}
