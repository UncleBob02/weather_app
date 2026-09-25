import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesDataSource {
  Future<void> saveLastCity(String city);

  Future<String?> getLastCity();
}

class PreferencesDataSourceImpl implements PreferencesDataSource{
  final SharedPreferences preferences;

  const PreferencesDataSourceImpl({
    required this.preferences,
  });

  @override
  Future<void> saveLastCity(String city) {
    return preferences.setString(
      'lastCity',
      city,
    );
  }

  @override
  Future<String?> getLastCity() async {
    return preferences.getString('lastCity');
  } 
}