import '../../domain/repositories/search_history_repository.dart';
import '../datasources/search_history_data_source.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository{
  final SearchHistoryDataSource dataSource;

  const SearchHistoryRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<void> saveSearch(String city) {
    return dataSource.saveSearch(city);
  }

  @override
  Future<List<String>> getSearchHistory() {
    return dataSource.getSearchHistory();
  }
}