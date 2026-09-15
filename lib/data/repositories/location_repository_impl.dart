import 'package:geolocator/geolocator.dart';

import '../../domain/repositories/location_repository.dart';
import '../datasources/location_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  const LocationRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Position> getCurrentPosition() {
    return dataSource.getCurrentPosition();
  }
}