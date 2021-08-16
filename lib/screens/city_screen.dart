import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/city_list_provider.dart';
import 'package:weather_app/services/get_location_data.dart';
import 'package:weather_app/services/shared_preference.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/widgets/city_list.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  bool isDisabled = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    disableButton();
  }

  void disableButton() {
    setState(() {
      if (Provider.of<CityListProvider>(context).cityCount >= 5) {
        isDisabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Night.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: isDisabled
                          ? null
                          : () {
                              if (cityName.trim().isEmpty == true) {
                                Fluttertoast.showToast(
                                    msg: "Please type in name of city",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Colors.redAccent.withOpacity(0.9),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                              Provider.of<CityListProvider>(context,
                                      listen: false)
                                  .addCityBase(cityName);
                              SharedPreference.pref(city: cityName);
                            },
                      child: Text(
                        'Add Favourite',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        GetLocationData.getLocationData(context, cityName);
                      },
                      child: Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: CityList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
