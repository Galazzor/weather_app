import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/widgets/city_tile.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  dynamic weatherData;

  Future<dynamic> getLocationData(String typedCity) async {
    var weatherService = WeatherService();
    var locationData =
        await weatherService.getWeatherCity(typedCity, diff: true);
    var weatherData = await weatherService.getOneCall(locationData);

    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Night.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  weatherData = await getLocationData(cityName);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if (cityName != null) {
                          return LocationScreen(
                            typedCity: cityName,
                            weatherData: weatherData,
                          );
                        } else {
                          return LocationScreen(
                            typedCity: cityName,
                          );
                        }
                      },
                    ),
                  );
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return CityTile();
                    },
                    itemCount: 8,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
