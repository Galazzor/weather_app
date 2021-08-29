import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/screens/location_screen.dart';

class MainScreen extends StatefulWidget {
  late final City currentCityData;
  late final List<Weather> currentWeatherData;
  late final List<City> cityData;
  late final List<List<Weather>> weatherData;

  MainScreen(
      {required this.currentCityData,
      required this.currentWeatherData,
      required this.cityData,
      required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = <Widget>[CityScreen()];

  void addScreens() {
    pages.add(LocationScreen(
        weatherData: widget.currentWeatherData,
        cityData: widget.currentCityData));
    for (int i = 0; i < widget.weatherData.length; i++) {
      pages.add(LocationScreen(
          weatherData: widget.weatherData[i], cityData: widget.cityData[i]));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addScreens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      itemBuilder: (context, index) => pages[index],
      itemCount: pages.length,
    ));
  }
}
