import '../repositories/preferences_repository.dart';

class GetLastCity {
  final PreferencesRepository repository;

  const GetLastCity(this.repository);

  Future<String?> call() {
    return repository.getLastCity();
  }
}