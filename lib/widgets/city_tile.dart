import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CityTile extends StatelessWidget {
  final String city;
  final VoidCallback weatherCallback;

  CityTile({required this.city, required this.weatherCallback});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => print('D'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => print('C'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => print('B'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print('A'),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: weatherCallback,
            child: Ink(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$city',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
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
