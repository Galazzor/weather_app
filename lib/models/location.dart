class Location {
  double latitude;
  double longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> jsonData,
      {bool diff = false}) {
    if (diff == false) {
      return Location(
        latitude: jsonData['latitude'],
        longitude: jsonData['longitude'],
      );
    } else {
      return Location(
        latitude: jsonData['coord']['lat'],
        longitude: jsonData['coord']['lon'],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'latitude': this.latitude,
        'longitude': this.longitude,
      };
}
