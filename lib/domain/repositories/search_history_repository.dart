abstract class SearchHistoryRepository {
  Future<void> saveSearch(String city);

  Future<List<String>> getSearchHistory();
}