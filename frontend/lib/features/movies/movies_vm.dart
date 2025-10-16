import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/movie.dart';
import '../../data/models/favorite.dart';
import '../../data/repositories/movie_repository.dart';
import '../../data/repositories/favorite_repository.dart';
import '../../core/i18n/language_provider.dart';

class MoviesState {
  final List<Movie> movies;
  final bool isLoading;
  final String? error;

  MoviesState({
    this.movies = const [],
    this.isLoading = false,
    this.error,
  });

  MoviesState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    String? error,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class MoviesViewModel extends StateNotifier<MoviesState> {
  MoviesViewModel(
    this._movieRepository,
    this._favoriteRepository,
    this._ref,
  ) : super(MoviesState()) {
    loadPopularMovies();
  }

  final MovieRepository _movieRepository;
  final FavoriteRepository _favoriteRepository;
  final Ref _ref;

  Future<void> loadPopularMovies() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final language = _ref.read(languageProvider.notifier).tmdbLanguage;
      final movies = await _movieRepository.getPopularMovies(
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

final moviesViewModelProvider =
    StateNotifierProvider<MoviesViewModel, MoviesState>((ref) {
  return MoviesViewModel(
    ref.watch(movieRepositoryProvider),
    ref.watch(favoriteRepositoryProvider),
    ref,
  );
});
