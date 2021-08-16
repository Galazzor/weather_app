//import 'package:weather_app/models/city_base_model.dart';
import 'package:weather_app/models/common/city_base.dart';
import 'storage/city_storage.dart';

class SharedPreference {
  static void pref({String? city}) async {
    /*await CityStorage.init();
    CityBase cityBase = CityBase(city: city);
    List<CityBase> tempList = <CityBase>[cityBase];
    CityBaseModel cityBaseModel = CityBaseModel();

    if (CityStorage.get().isEmpty && city == null) {
      return;
    } else if (CityStorage.get().isEmpty && city != null) {
      CityStorage.set(tempList);
    } else if (CityStorage.get().isNotEmpty && city == null) {
      var cityBaseStorage = CityStorage.get();
      cityBaseStorage.forEach((element) {
        cityBaseModel.addCityBase(element.city);
      });
    } else {
      var cityBaseStorage = CityStorage.get();
      tempList.addAll(cityBaseStorage);
      CityStorage.set(tempList);
    }*/
  }
}
