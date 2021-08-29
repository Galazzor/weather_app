import 'package:equatable/equatable.dart';

class CityBase extends Equatable {
  final String cityName;

  CityBase({required this.cityName});

  factory CityBase.fromJson(Map<String, dynamic> jsonData) {
    return CityBase(
      cityName: jsonData['city'],
    );
  }

  Map<String, dynamic> toJson() => {
        'city': this.cityName,
      };

  @override
  List<Object?> get props => [cityName];
}
