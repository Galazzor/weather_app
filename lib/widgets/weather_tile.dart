import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherTile extends StatefulWidget {
  final int index;
  final Weather weather;
  final Function(Weather) updateFront;
  final Function(int) updateTile;

  WeatherTile(
      {required this.weather,
      required this.updateFront,
      required this.updateTile,
      required this.index});

  @override
  _WeatherTileState createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.orangeAccent.withOpacity(0.5),
        ),
        color: widget.weather.isSelected == true
            ? Color(0xff1F2F47)
            : Color(0xff77B6EA),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      width: 100.0,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: InkWell(
        borderRadius: BorderRadius.circular(30.0),
        splashColor: Color(0xff37393A).withOpacity(0.3),
        onTap: () {
          setState(() {
            widget.updateFront(widget.weather);
            widget.updateTile(widget.index);
          });
        },
        child: Ink(
          width: 100.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Text(
                  widget.weather.time,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                CircleAvatar(
                  child: Image.network(
                      'http://openweathermap.org/img/wn/${widget.weather.icon}@2x.png'),
                  backgroundColor: Color(0xff10103b),
                  radius: 30.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${widget.weather.temperature}°C',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                BoxedIcon(
                  WeatherIcons.raindrop,
                  color: Colors.lightBlueAccent,
                ),
                Text(
                  '${widget.weather.precipitation.round()}%',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
