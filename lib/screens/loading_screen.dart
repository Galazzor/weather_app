import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/city_list_provider.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/services/web_api/weather_api_impl.dart';
import 'package:weather_app/services/current_location_service.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static var currentCityData;
  static var currentWeatherData;
  static List<City> cityData = <City>[];
  static List<List<Weather>> weatherData = <List<Weather>>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<CityListProvider>(context).loadData();
    await getCurrentLocationData();
    await getLocationData();
    await showPages();
  }

  Future<void> getCurrentLocationData() async {
    var location = await CurrentLocationService.get();
    var weatherService = WeatherApiImpl();
    currentCityData = await weatherService.getWeatherByLocation(location);
    currentWeatherData = await weatherService.getOneCall(location);
  }

  Future<void> getLocationData() async {
    var weatherService = WeatherApiImpl();

    for (int i = 0;
        i < Provider.of<CityListProvider>(context, listen: false).cityCount;
        i++) {
      var tempLocation = await weatherService.getWeatherByCity(
          Provider.of<CityListProvider>(context, listen: false)
              .cityBases[i]
              .cityName);
      var tempCityData =
          await weatherService.getWeatherByLocation(tempLocation.location);
      var tempWeatherData =
          await weatherService.getOneCall(tempLocation.location);

      cityData.add(tempCityData);
      weatherData.add(tempWeatherData);
    }
  }

  Future<void> showPages() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        currentCityData: currentCityData,
        currentWeatherData: currentWeatherData,
        cityData: cityData,
        weatherData: weatherData,
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
          'https://assets3.lottiefiles.com/datafiles/5mP0vh2UJOqS1DG/data.json',
        ),
      ),
    );
  }
}
