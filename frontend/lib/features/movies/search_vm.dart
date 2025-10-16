import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/movie.dart';
import '../../data/repositories/movie_repository.dart';
import '../../data/repositories/favorite_repository.dart';
import '../../data/models/favorite.dart';
import '../../core/i18n/language_provider.dart';

class SearchState {
  final List<Movie> movies;
  final bool isLoading;
  final String? error;
  final String query;

  SearchState({
    this.movies = const [],
    this.isLoading = false,
    this.error,
    this.query = '',
  });

  SearchState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    String? error,
    String? query,
  }) {
    return SearchState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      query: query ?? this.query,
    );
  }
}

class SearchViewModel extends StateNotifier<SearchState> {
  SearchViewModel(
    this._movieRepository,
    this._favoriteRepository,
    this._ref,
  ) : super(SearchState());

  final MovieRepository _movieRepository;
  final FavoriteRepository _favoriteRepository;
  final Ref _ref;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = state.copyWith(movies: [], query: query);
      return;
    }

    state = state.copyWith(isLoading: true, error: null, query: query);

    try {
      final language = _ref.read(languageProvider.notifier).tmdbLanguage;
      final movies = await _movieRepository.searchMovies(
        query: query,
        language: language,
      );
      state = state.copyWith(movies: movies, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addToFavorites(Movie movie) async {
    try {
      await _favoriteRepository.addFavorite(movie, FavoriteStatus.watchlist);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isFavorite(int tmdbId) async {
    return _favoriteRepository.isFavorite(tmdbId);
  }
}

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>((ref) {
  return SearchViewModel(
    ref.watch(movieRepositoryProvider),
    ref.watch(favoriteRepositoryProvider),
    ref,
  );
});
