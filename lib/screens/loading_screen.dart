import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/city_list_provider.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/web_api/weather_api_impl.dart';
import 'package:weather_app/services/current_location_service.dart';

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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<CityListProvider>(context).loadData();
  }

  void getLocationData() async {
    var location = await CurrentLocationService.get();
    var weatherService = WeatherApiImpl();
    var cityData = await weatherService.getWeatherByLocation(location);
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
