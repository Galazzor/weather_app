import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/common/city_base.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/city_list_provider.dart';
import 'package:weather_app/widgets/toast_message.dart';
import 'package:weather_app/widgets/weather_detail_tile.dart';
import 'package:weather_app/widgets/weather_tile.dart';
import 'package:weather_icons/weather_icons.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.weatherData, required this.cityData});

  final List<Weather> weatherData;
  final City cityData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Weather weather;
  late int temperature;
  late String time;
  late int precipitation;
  late int humidity;
  late int windSpeed;
  late int pressure;
  late String weekday;
  late String sunrise;
  late String sunset;
  late String icon;
  late String city;
  late String country;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.weatherData, widget.cityData);
  }

  void updateUI(List<Weather> weatherData, City cityData) {
    setState(() {
      icon = weatherData[0].icon;
      temperature = weatherData[0].temperature.toInt();
      weekday = weatherData[0].weekday;
      time = weatherData[0].time;
      precipitation = weatherData[0].precipitation.toInt();
      humidity = weatherData[0].humidity.toInt();
      windSpeed = weatherData[0].windSpeed.toInt();
      pressure = weatherData[0].pressure.toInt();
      city = cityData.cityName;
      country = cityData.country;
      sunrise = cityData.sunrise;
      sunset = cityData.sunset;
    });
  }

  void updateFront(Weather weather) {
    setState(() {
      precipitation = weather.precipitation.toInt();
      humidity = weather.humidity.toInt();
      windSpeed = weather.windSpeed.toInt();
      pressure = weather.pressure.toInt();
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Night.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        ('$city, $country'),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: FlatButton(
                            onPressed: () async {
                              CityBase cityBase = CityBase(cityName: city);
                              try {
                                if (!Provider.of<CityListProvider>(context,
                                        listen: false)
                                    .cityBases
                                    .contains(cityBase)) {
                                  Provider.of<CityListProvider>(context,
                                          listen: false)
                                      .addCityBase(city);
                                  ToastMessage.showMessage(
                                      message: 'Successfully added this city');
                                } else {
                                  throw Exception();
                                }
                              } catch (e) {
                                ToastMessage.showMessage(
                                    message: 'Could not add this city');
                              }
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xfffcf4e3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Column(
                      children: [
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          weekday,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        child: Image.network(
                          'http://openweathermap.org/img/wn/$icon@2x.png',
                        ),
                      ),
                      Text(
                        '$temperature°C',
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxedIcon(
                        WeatherIcons.sunrise,
                        color: Colors.yellowAccent,
                      ),
                      Text(
                        sunrise,
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
                        sunset,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0, top: 20.0, right: 5.0),
                    height: 130,
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
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding:
                        EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        WeatherDetailTile(
                          firstDetailName: 'Sunrise',
                          firstDetailValue: sunrise,
                          secondDetailName: 'Sunset',
                          secondDetailValue: sunset,
                        ),
                        Divider(),
                        WeatherDetailTile(
                          firstDetailName: 'Precipitation',
                          firstDetailValue: precipitation.toString() + '%',
                          secondDetailName: 'Humidity',
                          secondDetailValue: humidity.toString() + '%',
                        ),
                        Divider(),
                        WeatherDetailTile(
                          firstDetailName: 'Wind',
                          firstDetailValue: windSpeed.toString() + ' km/h',
                          secondDetailName: 'Pressure',
                          secondDetailValue: pressure.toString() + ' hPa',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
