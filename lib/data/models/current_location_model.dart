class CurrentLocationModel {
  final String city;

  const CurrentLocationModel({
    required this.city,
  });

  factory CurrentLocationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final city = json['city'] ?? json['locality'];

    if (city == null || city.toString().isEmpty) {
      throw const FormatException(
        'Could not determine the city.'
      );
    }

    return CurrentLocationModel(
      city: city.toString()
    );
  }
}