import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/service/location.dart';
import 'package:weather_app/service/weather_data.dart';
import 'package:weather_app/widgets/weather_tile.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(
      {this.weatherData,
      this.locationCity,
      this.locationCountry,
      this.typedCity,
      this.country});

  final dynamic weatherData;
  final String locationCity;
  final String locationCountry;
  final String typedCity;
  final String country;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Weather> weathers = [];
  Weather weather;
  int currentTemperature;
  String currentTime;
  String currentWeekday;
  String currentSunrise;
  String currentSunset;
  String currentIcon;
  String icon;
  String city;
  String country;
  double precipitation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    putIntoList(widget.weatherData);
    updateUI(widget.weatherData, widget.locationCity, widget.locationCountry);
  }

  void putIntoList(dynamic weatherData) {
    for (int i = 0; i <= 24; i++) {
      num temp = weatherData['hourly'][i]['temp'];
      num tempPrep = weatherData['hourly'][i]['pop'];
      int tempEpoch = weatherData['hourly'][i]['dt'];
      Weather weather = Weather(
          temperature: temp.toInt(),
          icon: weatherData['hourly'][i]['weather'][0]['icon'],
          precipitation: tempPrep.toDouble() * 100,
          time: calculateTimeToString(tempEpoch));
      weathers.add(weather);
    }
  }

  String calculateWeekdayToString(int epoch) {
    DateTime temp = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('EEEE, d MMM').format(temp);
  }

  String calculateTimeToString(int epoch) {
    DateTime temp = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('jm').format(temp);
  }

  void updateUI(dynamic weatherData, String city, String country) {
    setState(() {
      weathers[0].isSelected = true;
      num temp = weatherData['hourly'][0]['temp'];
      currentIcon = weatherData['hourly'][0]['weather'][0]['icon'];
      int timeEpoch = weatherData['hourly'][0]['dt'];
      int sunriseEpoch = weatherData['current']['sunrise'];
      int sunsetEpoch = weatherData['current']['sunset'];
      currentTemperature = temp.toInt();
      currentWeekday = calculateWeekdayToString(timeEpoch);
      currentTime = calculateTimeToString(timeEpoch);
      currentSunrise = calculateTimeToString(sunriseEpoch);
      currentSunset = calculateTimeToString(sunsetEpoch);
      this.city = city;
      this.country = country;
    });
  }

  void updateFront(Weather weather) {
    setState(() {
      currentIcon = weather.icon;
      currentTemperature = weather.temperature;
      currentTime = weather.time;
    });
  }

  void updateTile(int index) {
    setState(() {
      weathers.forEach((element) => element.isSelected = false);
      weathers[index].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffce6d),
        body: Column(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/Day.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Color(0xff10103b).withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              constraints: BoxConstraints.tightForFinite(height: 380.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ('$city, $country'),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            child: Image.network(
                              'http://openweathermap.org/img/wn/$currentIcon@2x.png',
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                currentTime == null ? 'Empty' : currentTime,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                currentWeekday == null
                                    ? 'Empty'
                                    : currentWeekday,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '$currentTemperature°C',
                      style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoxedIcon(
                          WeatherIcons.sunrise,
                          color: Colors.yellowAccent,
                        ),
                        Text(
                          currentSunrise == null ? 'Empty' : currentSunrise,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        BoxedIcon(
                          WeatherIcons.sunset,
                          color: Colors.yellowAccent,
                        ),
                        Text(
                          currentSunset == null ? 'Empty' : currentSunset,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    child: WeatherTile(
                      weather: weathers[index],
                      index: index,
                      updateFront: updateFront,
                      updateTile: updateTile,
                    ),
                  );
                },
                itemCount: weathers.length,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CityScreen()));
              },
              child: Text('Press'),
            ),
          ],
        ),
      ),
    );
  }
}
