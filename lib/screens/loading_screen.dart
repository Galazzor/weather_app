import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/service/current_location_provider.dart';
import 'package:weather_app/service/weather_service.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var location = await CurrentLocationProvider.get();
    var weatherService = WeatherService();
    var cityData = await weatherService.getWeather(location);
    var weatherData = await weatherService.getOneCall(location);

    await Future.delayed(Duration(seconds: 2));
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherData,
        cityData: cityData,
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.lightBlueAccent,
          size: 100.0,
        ),
      ),
    );
  }
}
