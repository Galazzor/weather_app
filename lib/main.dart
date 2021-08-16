import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/city_list_provider.dart';
import 'package:weather_app/screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CityListProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoadingScreen(),
      ),
    );
  }
}
