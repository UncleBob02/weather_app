import '../repositories/preferences_repository.dart';

class SaveLastCity {
  final PreferencesRepository repository;

  const SaveLastCity(this.repository);

  Future<void> call(String city) {
    return repository.saveLastCity(city);
  }
}