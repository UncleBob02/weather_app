class LocationModel {
  final String name;
  final double latitude;
  final double longitude;
  final String countryCode;

  LocationModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      countryCode: json['country_code'] as String,
    );
  }
}