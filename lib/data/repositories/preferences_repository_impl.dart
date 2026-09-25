import '../datasources/preferences_data_source.dart';
import '../../domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository{
    final PreferencesDataSource dataSource;

    const PreferencesRepositoryImpl ({
        required this.dataSource,
    });

    @override
    Future<void> saveLastCity(String city) {
        return dataSource.saveLastCity(city);
    }

    @override
    Future<String?> getLastCity() {
        return dataSource.getLastCity();
    } 
}