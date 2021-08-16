class Location {
  double latitude;
  double longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> jsonData) {
    return Location(
      latitude: jsonData['latitude'],
      longitude: jsonData['longitude'],
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': this.latitude,
        'longitude': this.longitude,
      };
}
