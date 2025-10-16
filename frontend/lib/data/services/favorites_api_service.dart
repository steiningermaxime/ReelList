import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_config.dart';
import '../models/favorite.dart';

class FavoritesApiService {
  FavoritesApiService(this._dio);

  final Dio _dio;

  Future<List<Favorite>> getFavorites({FavoriteStatus? status}) async {
    final queryParams = <String, dynamic>{};
    
    if (status != null) {
      queryParams['status'] = 'eq.${status.name}';
    }
    
    queryParams['select'] = '*';
    queryParams['order'] = 'added_at.desc';

    final response = await _dio.get<List<dynamic>>(
      ApiEndpoints.favorites,
      queryParameters: queryParams,
    );

    return (response.data ?? [])
        .map((json) => Favorite.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Favorite> createFavorite(CreateFavoriteDto dto) async {
    final response = await _dio.post<List<dynamic>>(
      ApiEndpoints.favorites,
      data: dto.toJson(),
      options: Options(
        headers: {'Prefer': 'return=representation'},
      ),
    );

    final data = response.data;
    if (data == null || data.isEmpty) {
      throw Exception('No data returned from server');
    }

    return Favorite.fromJson(data.first as Map<String, dynamic>);
  }

  Future<Favorite> updateFavorite(String id, UpdateFavoriteDto dto) async {
    final response = await _dio.patch<List<dynamic>>(
      ApiEndpoints.favorites,
      queryParameters: {'id': 'eq.$id'},
      data: dto.toJson(),
      options: Options(
        headers: {'Prefer': 'return=representation'},
      ),
    );

    final data = response.data;
    if (data == null || data.isEmpty) {
      throw Exception('No data returned from server');
    }

    return Favorite.fromJson(data.first as Map<String, dynamic>);
  }

  Future<void> deleteFavorite(String id) async {
    await _dio.delete(
      ApiEndpoints.favorites,
      queryParameters: {'id': 'eq.$id'},
    );
  }

  Future<Favorite?> getFavoriteByTmdbId(int tmdbId) async {
    final response = await _dio.get<List<dynamic>>(
      ApiEndpoints.favorites,
      queryParameters: {
        'tmdb_id': 'eq.$tmdbId',
        'select': '*',
      },
    );

    final data = response.data;
    if (data == null || data.isEmpty) {
      return null;
    }

    return Favorite.fromJson(data.first as Map<String, dynamic>);
  }
}

final favoritesApiServiceProvider = Provider<FavoritesApiService>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.supabaseUrl,
      headers: {
        'apikey': ApiConfig.supabaseApiKey,
        'Authorization': 'Bearer ${ApiConfig.supabaseApiKey}',
        'Content-Type': 'application/json',
      },
    ),
  );
  return FavoritesApiService(dio);
});
