import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_config.dart';
import '../models/movie.dart';

class TmdbApiService {
  TmdbApiService(this._dio);

  final Dio _dio;

  Future<List<Movie>> searchMovies({
    required String query,
    String language = 'fr-FR',
    int page = 1,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.tmdbSearchMovie,
      queryParameters: {
        'api_key': ApiConfig.tmdbApiKey,
        'query': query,
        'language': language,
        'page': page,
      },
    );

    final results = response.data?['results'] as List<dynamic>? ?? [];
    return results.map((json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<Movie> getMovieDetails({
    required int movieId,
    String language = 'fr-FR',
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '${ApiEndpoints.tmdbMovieDetails}/$movieId',
      queryParameters: {
        'api_key': ApiConfig.tmdbApiKey,
        'language': language,
      },
    );

    return Movie.fromJson(response.data!);
  }
}

final tmdbApiServiceProvider = Provider<TmdbApiService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: ApiConfig.tmdbBaseUrl));
  return TmdbApiService(dio);
});
