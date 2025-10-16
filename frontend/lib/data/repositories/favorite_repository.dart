import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/favorite.dart';
import '../models/movie.dart';
import '../services/favorites_api_service.dart';
import '../local/local_store.dart';

abstract class FavoriteRepository {
  Future<List<Favorite>> getFavorites({FavoriteStatus? status});
  Future<Favorite> addFavorite(Movie movie, FavoriteStatus status);
  Future<Favorite> updateFavorite(String id, UpdateFavoriteDto dto);
  Future<void> deleteFavorite(String id);
  Future<Favorite?> getFavoriteByTmdbId(int tmdbId);
  Future<bool> isFavorite(int tmdbId);
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl({
    required this.apiService,
    required this.localStore,
  });

  final FavoritesApiService apiService;
  final LocalStore localStore;

  @override
  Future<List<Favorite>> getFavorites({FavoriteStatus? status}) async {
    try {
      final favorites = await apiService.getFavorites(status: status);
      
      await localStore.cacheFavorites(
        favorites.map((f) => f.toJson()).toList(),
      );
      
      return favorites;
    } catch (e) {
      final cached = localStore.getCachedFavorites();
      if (cached != null) {
        final favorites = cached.map((json) => Favorite.fromJson(json)).toList();
        
        if (status != null) {
          return favorites.where((f) => f.status == status).toList();
        }
        
        return favorites;
      }
      rethrow;
    }
  }

  @override
  Future<Favorite> addFavorite(Movie movie, FavoriteStatus status) async {
    final dto = CreateFavoriteDto(
      tmdbId: movie.tmdbId,
      title: movie.title,
      posterUrl: movie.posterUrl,
      overview: movie.overview,
      releaseYear: movie.releaseYear,
      status: status,
      watchedAt: status == FavoriteStatus.watched ? DateTime.now() : null,
    );

    final favorite = await apiService.createFavorite(dto);
    
    await _updateCachedFavorites();
    
    return favorite;
  }

  @override
  Future<Favorite> updateFavorite(String id, UpdateFavoriteDto dto) async {
    final favorite = await apiService.updateFavorite(id, dto);
    
    await _updateCachedFavorites();
    
    return favorite;
  }

  @override
  Future<void> deleteFavorite(String id) async {
    await apiService.deleteFavorite(id);
    
    await _updateCachedFavorites();
  }

  @override
  Future<Favorite?> getFavoriteByTmdbId(int tmdbId) async {
    try {
      return await apiService.getFavoriteByTmdbId(tmdbId);
    } catch (e) {
      final cached = localStore.getCachedFavorites();
      if (cached != null) {
        final favorites = cached.map((json) => Favorite.fromJson(json)).toList();
        try {
          return favorites.firstWhere((f) => f.tmdbId == tmdbId);
        } catch (_) {
          return null;
        }
      }
      return null;
    }
  }

  @override
  Future<bool> isFavorite(int tmdbId) async {
    final favorite = await getFavoriteByTmdbId(tmdbId);
    return favorite != null;
  }

  Future<void> _updateCachedFavorites() async {
    try {
      final favorites = await apiService.getFavorites();
      await localStore.cacheFavorites(
        favorites.map((f) => f.toJson()).toList(),
      );
    } catch (_) {
    }
  }
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepositoryImpl(
    apiService: ref.watch(favoritesApiServiceProvider),
    localStore: ref.watch(localStoreProvider),
  );
});
