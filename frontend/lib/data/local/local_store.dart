import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HiveBoxNames {
  static const String movies = 'movies_box';
  static const String favorites = 'favorites_box';
  static const String prefs = 'prefs_box';
}

class PrefsKeys {
  static const String theme = 'theme';
  static const String locale = 'locale';
  static const String token = 'token';
}

class LocalStore {
  Box<dynamic>? _moviesBox;
  Box<dynamic>? _favoritesBox;
  Box<dynamic>? _prefsBox;

  Future<void> init() async {
    await Hive.initFlutter();

    _moviesBox = await Hive.openBox(HiveBoxNames.movies);
    _favoritesBox = await Hive.openBox(HiveBoxNames.favorites);
    _prefsBox = await Hive.openBox(HiveBoxNames.prefs);
  }

  Box<dynamic> get moviesBox {
    if (_moviesBox == null || !_moviesBox!.isOpen) {
      throw Exception('Movies box not initialized');
    }
    return _moviesBox!;
  }

  Box<dynamic> get favoritesBox {
    if (_favoritesBox == null || !_favoritesBox!.isOpen) {
      throw Exception('Favorites box not initialized');
    }
    return _favoritesBox!;
  }

  Box<dynamic> get prefsBox {
    if (_prefsBox == null || !_prefsBox!.isOpen) {
      throw Exception('Prefs box not initialized');
    }
    return _prefsBox!;
  }

  T? get<T>(String boxName, String key) {
    final box = _getBox(boxName);
    return box.get(key) as T?;
  }

  Future<void> put(String boxName, String key, dynamic value) async {
    final box = _getBox(boxName);
    await box.put(key, value);
  }

  Future<void> delete(String boxName, String key) async {
    final box = _getBox(boxName);
    await box.delete(key);
  }

  Future<void> clear(String boxName) async {
    final box = _getBox(boxName);
    await box.clear();
  }

  List<dynamic> getAll(String boxName) {
    final box = _getBox(boxName);
    return box.values.toList();
  }

  Map<dynamic, dynamic> getAllAsMap(String boxName) {
    final box = _getBox(boxName);
    return box.toMap();
  }

  bool containsKey(String boxName, String key) {
    final box = _getBox(boxName);
    return box.containsKey(key);
  }

  Box<dynamic> _getBox(String boxName) {
    switch (boxName) {
      case HiveBoxNames.movies:
        return moviesBox;
      case HiveBoxNames.favorites:
        return favoritesBox;
      case HiveBoxNames.prefs:
        return prefsBox;
      default:
        throw Exception('Unknown box: $boxName');
    }
  }

  String? getTheme() => get<String>(HiveBoxNames.prefs, PrefsKeys.theme);

  Future<void> setTheme(String theme) =>
      put(HiveBoxNames.prefs, PrefsKeys.theme, theme);

  String? getLocale() => get<String>(HiveBoxNames.prefs, PrefsKeys.locale);

  Future<void> setLocale(String locale) =>
      put(HiveBoxNames.prefs, PrefsKeys.locale, locale);

  String? getToken() => get<String>(HiveBoxNames.prefs, PrefsKeys.token);

  Future<void> setToken(String token) =>
      put(HiveBoxNames.prefs, PrefsKeys.token, token);

  Future<void> clearToken() =>
      delete(HiveBoxNames.prefs, PrefsKeys.token);

  Future<void> cacheMovies(Map<String, dynamic> movies) async {
    await put(HiveBoxNames.movies, 'cached_movies', movies);
  }

  Map<String, dynamic>? getCachedMovies() {
    return get<Map<String, dynamic>>(HiveBoxNames.movies, 'cached_movies');
  }

  Future<void> cacheFavorites(List<Map<String, dynamic>> favorites) async {
    await put(HiveBoxNames.favorites, 'cached_favorites', favorites);
  }

  List<Map<String, dynamic>>? getCachedFavorites() {
    final cached = get<List<dynamic>>(HiveBoxNames.favorites, 'cached_favorites');
    return cached?.cast<Map<String, dynamic>>();
  }

  Future<void> cacheSearchResults(String query, String lang, List<Map<String, dynamic>> results) async {
    final key = 'search_${query}_$lang';
    await put(HiveBoxNames.movies, key, results);
  }

  List<Map<String, dynamic>>? getCachedSearchResults(String query, String lang) {
    final key = 'search_${query}_$lang';
    final cached = get<List<dynamic>>(HiveBoxNames.movies, key);
    return cached?.cast<Map<String, dynamic>>();
  }

  Future<void> clearAllCache() async {
    await clear(HiveBoxNames.movies);
    await clear(HiveBoxNames.favorites);
  }

  Future<void> close() async {
    await _moviesBox?.close();
    await _favoritesBox?.close();
    await _prefsBox?.close();
  }
}

final localStoreProvider = Provider<LocalStore>((ref) {
  throw UnimplementedError('LocalStore must be initialized in main()');
});
