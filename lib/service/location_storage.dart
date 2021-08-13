import 'package:shared_preferences/shared_preferences.dart';
import '../models/location.dart';
import 'dart:convert';

class LocationStorage {
  static SharedPreferences _preferences;

  static const _keyLocations = 'locations';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future set(List<Location> locations) async =>
      await _preferences.setString(_keyLocations, json.encode(locations));

  static List<Location> get() {
    var data =
        json.decode(_preferences.getString(_keyLocations)) as List<dynamic>;
    return data.map((e) => Location.fromJson(e)).toList();
  }
}
