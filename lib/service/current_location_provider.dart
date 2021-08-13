import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/location.dart';

class CurrentLocationProvider {
  static Future<Location> get() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return Location(latitude: position.latitude, longitude: position.longitude);
  }
}
