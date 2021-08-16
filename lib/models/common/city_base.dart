class CityBase {
  final String city;

  CityBase({required this.city});

  factory CityBase.fromJson(Map<String, dynamic> jsonData) {
    return CityBase(
      city: jsonData['city'],
    );
  }

  Map<String, dynamic> toJson() => {
        'city': this.city,
      };
}
