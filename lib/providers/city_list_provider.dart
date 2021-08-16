import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:weather_app/models/common/city_base.dart';
import 'package:weather_app/services/storage/city_storage.dart';

class CityListProvider extends ChangeNotifier {
  static List<CityBase> _cityBases = <CityBase>[];
  CityStorage _cityStorage = CityStorage();

  UnmodifiableListView<CityBase> get cityBases {
    return UnmodifiableListView((_cityBases));
  }

  int get cityCount {
    return _cityBases.length;
  }

  void loadData() async {
    _cityBases = await _cityStorage.get();
  }

  void addCityBase(String city) {
    final cityBase = CityBase(city: city);
    _cityBases.add(cityBase);
    _cityStorage.set(_cityBases);
    notifyListeners();
  }

  void deleteCityBase(CityBase cityBase) {
    _cityBases.remove(cityBase);
    _cityStorage.set(_cityBases);
    notifyListeners();
  }
}
