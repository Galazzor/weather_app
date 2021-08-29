import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/city_list_provider.dart';

class CityTile extends StatelessWidget {
  final String city;
  final VoidCallback weatherCallback;

  CityTile({required this.city, required this.weatherCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.25,
        actions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => Provider.of<CityListProvider>(context, listen: false)
                .deleteCityBase(city),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff0B58CA).withOpacity(0.75),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Text(
              city,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffF2E2BA),
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              'Progress',
              style: TextStyle(
                color: Color(0xffF2E2BA),
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: weatherCallback,
          ),
        ),
      ),
    );
  }
}
