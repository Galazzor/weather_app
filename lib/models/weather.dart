class Weather {
  bool isSelected = false;
  final int temperature;
  final String time;
  final String sunrise;
  final String sunset;
  final String icon;
  final double precipitation;

  Weather(
      {this.isSelected,
      this.temperature,
      this.time,
      this.sunrise,
      this.sunset,
      this.icon,
      this.precipitation});
}
