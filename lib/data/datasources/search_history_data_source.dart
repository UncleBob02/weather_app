import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchHistoryDataSource {
  Future<void> saveSearch(String city);

  Future<List<String>> getSearchHistory(); 
}

class SearchHistoryDataSourceIpml implements SearchHistoryDataSource {
  final SharedPreferences preferences;

  const SearchHistoryDataSourceIpml({
    required this.preferences,
  });

  @override
  Future<void> saveSearch(String city) async {
    final history = await getSearchHistory();

    history.remove(city);
    history.insert(0, city);

    if (history.length > 5) {
      history.removeLast();
    }

    await preferences.setStringList(
      'searchHistory', 
      history,
    );
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return preferences.getStringList(
      'searchHistory',  
    ) ??
    [];
  }
}