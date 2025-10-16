import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie.dart';
import '../services/tmdb_api_service.dart';
import '../local/local_store.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovies({
    required String query,
    String language = 'fr-FR',
  });
  
  Future<Movie> getMovieDetails(int movieId, {String language = 'fr-FR'});
}

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({
    required this.apiService,
    required this.localStore,
  });

  final TmdbApiService apiService;
  final LocalStore localStore;

  @override
  Future<List<Movie>> searchMovies({
    required String query,
    String language = 'fr-FR',
  }) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final cachedResults = localStore.getCachedSearchResults(query, language);
      if (cachedResults != null && cachedResults.isNotEmpty) {
        return cachedResults
            .map((json) => Movie.fromJson(json))
            .toList();
      }

      final movies = await apiService.searchMovies(
        query: query,
        language: language,
      );

      await localStore.cacheSearchResults(
        query,
        language,
        movies.map((m) => m.toJson()).toList(),
      );

      return movies;
    } catch (e) {
      final cachedResults = localStore.getCachedSearchResults(query, language);
      if (cachedResults != null) {
        return cachedResults
            .map((json) => Movie.fromJson(json))
            .toList();
      }
      rethrow;
    }
  }

  @override
  Future<Movie> getMovieDetails(int movieId, {String language = 'fr-FR'}) async {
    return apiService.getMovieDetails(
      movieId: movieId,
      language: language,
    );
  }
}

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepositoryImpl(
    apiService: ref.watch(tmdbApiServiceProvider),
    localStore: ref.watch(localStoreProvider),
  );
});
