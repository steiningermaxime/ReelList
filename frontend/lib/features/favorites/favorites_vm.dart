import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/favorite.dart';
import '../../data/repositories/favorite_repository.dart';

class FavoritesState {
  final List<Favorite> favorites;
  final bool isLoading;
  final String? error;
  final FavoriteStatus? filter;

  FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
    this.error,
    this.filter,
  });

  FavoritesState copyWith({
    List<Favorite>? favorites,
    bool? isLoading,
    String? error,
    FavoriteStatus? filter,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filter: filter ?? this.filter,
    );
  }
}

class FavoritesViewModel extends StateNotifier<FavoritesState> {
  FavoritesViewModel(this._repository) : super(FavoritesState()) {
    loadFavorites();
  }

  final FavoriteRepository _repository;

  Future<void> loadFavorites({FavoriteStatus? status}) async {
    state = state.copyWith(isLoading: true, error: null, filter: status);

    try {
      final favorites = await _repository.getFavorites(status: status);
      state = state.copyWith(favorites: favorites, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteFavorite(String id) async {
    try {
      await _repository.deleteFavorite(id);
      await loadFavorites(status: state.filter);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFavorite(
    String id,
    UpdateFavoriteDto dto,
  ) async {
    try {
      await _repository.updateFavorite(id, dto);
      await loadFavorites(status: state.filter);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsWatched(String id, int rating, String? comment) async {
    final dto = UpdateFavoriteDto(
      status: FavoriteStatus.watched,
      personalRating: rating,
      personalComment: comment,
      watchedAt: DateTime.now(),
    );
    await updateFavorite(id, dto);
  }
}

final favoritesViewModelProvider =
    StateNotifierProvider<FavoritesViewModel, FavoritesState>((ref) {
  return FavoritesViewModel(ref.watch(favoriteRepositoryProvider));
});
