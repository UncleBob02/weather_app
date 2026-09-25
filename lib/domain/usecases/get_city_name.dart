import '../repositories/location_repository.dart';

class GetCityName {
  final LocationRepository repository;

  const GetCityName(this.repository);

  Future<String> call(
    double latitude,
    double longitude,
  ) {
    return repository.getCityName(
      latitude, 
      longitude,
    );
  }
}