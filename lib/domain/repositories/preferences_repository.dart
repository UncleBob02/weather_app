abstract class PreferencesRepository {
  Future<void> saveLastCity(String city);

  Future<String?> getLastCity();
}