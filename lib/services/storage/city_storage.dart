import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/common/city_base.dart';
import 'dart:convert';

class CityStorage {
  static const _keyCities = 'cities';

  Future set(List<CityBase> cities) async =>
      (await _sharedPreferences()).setString(_keyCities, json.encode(cities));

  Future<List<CityBase>> get() async {
    var prefData = (await _sharedPreferences()).getString(_keyCities) ?? "[]";
    var data = json.decode(prefData) as List<dynamic>;
    return data.map((e) => CityBase.fromJson(e)).toList();
  }

  Future<SharedPreferences> _sharedPreferences() async =>
      await SharedPreferences.getInstance();
}
