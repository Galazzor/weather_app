import 'package:flutter/material.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'models/location.dart';
import 'package:weather_app/service/location_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocationStorage.init();

  List<Location> locations = <Location>[
    Location(latitude: 45.9953, longitude: 16.95538),
    Location(latitude: 49.9953, longitude: 26.95538)
  ];

  LocationStorage.set(locations);
  var temp = LocationStorage.get();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoadingScreen(),
    );
  }
}
