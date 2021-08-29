import 'package:flutter/material.dart';

class WeatherDetailTile extends StatelessWidget {
  late final String firstDetailName;
  late final String secondDetailName;
  late final String firstDetailValue;
  late final String secondDetailValue;

  WeatherDetailTile(
      {required this.firstDetailName,
      required this.firstDetailValue,
      required this.secondDetailName,
      required this.secondDetailValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstDetailName,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              firstDetailValue,
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
        Spacer(
          flex: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondDetailName,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              secondDetailValue,
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
