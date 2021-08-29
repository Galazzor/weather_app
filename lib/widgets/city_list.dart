import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/city_list_provider.dart';
import 'package:weather_app/services/get_location_data.dart';
import 'package:weather_app/widgets/city_tile.dart';

class CityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CityListProvider>(builder: (context, cityBaseModel, child) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final cityBase = cityBaseModel.cityBases[index];
          return CityTile(
            city: cityBase.cityName,
            weatherCallback: () =>
                GetLocationData.getLocationData(context, cityBase.cityName),
          );
        },
        itemCount: cityBaseModel.cityCount,
      );
    });
  }
}
