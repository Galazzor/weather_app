import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/widgets/weather_tile.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.weatherData, required this.cityData});

  final List<Weather> weatherData;
  final City cityData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Weather weather;
  late int currentTemperature;
  late String currentTime;
  late String currentWeekday;
  late String currentSunrise;
  late String currentSunset;
  late String currentIcon;
  late String icon;
  late String city;
  late String country;
  late double precipitation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.weatherData[0].isSelected = true;
    updateUI(widget.weatherData, widget.cityData);
  }

  String calculateWeekdayToString(int epoch) {
    DateTime temp = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('EEEE, d MMM').format(temp);
  }

  String calculateTimeToString(int epoch) {
    DateTime temp = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('jm').format(temp);
  }

  void updateUI(List<Weather> weatherData, City cityData) {
    setState(() {
      currentIcon = weatherData[0].icon;
      currentTemperature = weatherData[0].temperature.toInt();
      currentWeekday = weatherData[0].weekday;
      currentTime = weatherData[0].time;
      this.city = cityData.city;
      this.country = cityData.country;
      this.currentSunrise = cityData.sunrise;
      this.currentSunset = cityData.sunset;
    });
  }

  void updateFront(Weather weather) {
    setState(() {
      currentIcon = weather.icon;
      currentTemperature = weather.temperature.toInt();
      currentTime = weather.time;
    });
  }

  void updateTile(int index) {
    setState(() {
      widget.weatherData.forEach((element) => element.isSelected = false);
      widget.weatherData[index].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffce6d),
        body: SingleChildScrollView(
          child: Column(
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
                        ('${city}, ${country}'),
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
                        weather: widget.weatherData[index],
                        index: index,
                        updateFront: updateFront,
                        updateTile: updateTile,
                      ),
                    );
                  },
                  itemCount: widget.weatherData.length,
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
      ),
    );
  }
}
