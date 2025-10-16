// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
  id: json['id'] as String,
  tmdbId: (json['tmdb_id'] as num).toInt(),
  title: json['title'] as String,
  posterUrl: json['poster_url'] as String?,
  overview: json['overview'] as String?,
  releaseYear: (json['release_year'] as num?)?.toInt(),
  status: $enumDecode(_$FavoriteStatusEnumMap, json['status']),
  personalRating: (json['personal_rating'] as num?)?.toInt(),
  personalComment: json['personal_comment'] as String?,
  addedAt: DateTime.parse(json['added_at'] as String),
  watchedAt: json['watched_at'] == null
      ? null
      : DateTime.parse(json['watched_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
  'id': instance.id,
  'tmdb_id': instance.tmdbId,
  'title': instance.title,
  'poster_url': instance.posterUrl,
  'overview': instance.overview,
  'release_year': instance.releaseYear,
  'status': _$FavoriteStatusEnumMap[instance.status]!,
  'personal_rating': instance.personalRating,
  'personal_comment': instance.personalComment,
  'added_at': instance.addedAt.toIso8601String(),
  'watched_at': instance.watchedAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$FavoriteStatusEnumMap = {
  FavoriteStatus.watchlist: 'watchlist',
  FavoriteStatus.watched: 'watched',
};

CreateFavoriteDto _$CreateFavoriteDtoFromJson(Map<String, dynamic> json) =>
    CreateFavoriteDto(
      tmdbId: (json['tmdb_id'] as num).toInt(),
      title: json['title'] as String,
      posterUrl: json['poster_url'] as String?,
      overview: json['overview'] as String?,
      releaseYear: (json['release_year'] as num?)?.toInt(),
      status: $enumDecode(_$FavoriteStatusEnumMap, json['status']),
      personalRating: (json['personal_rating'] as num?)?.toInt(),
      personalComment: json['personal_comment'] as String?,
      watchedAt: json['watched_at'] == null
          ? null
          : DateTime.parse(json['watched_at'] as String),
    );

Map<String, dynamic> _$CreateFavoriteDtoToJson(CreateFavoriteDto instance) =>
    <String, dynamic>{
      'tmdb_id': instance.tmdbId,
      'title': instance.title,
      'poster_url': instance.posterUrl,
      'overview': instance.overview,
      'release_year': instance.releaseYear,
      'status': _$FavoriteStatusEnumMap[instance.status]!,
      'personal_rating': instance.personalRating,
      'personal_comment': instance.personalComment,
      'watched_at': instance.watchedAt?.toIso8601String(),
    };

UpdateFavoriteDto _$UpdateFavoriteDtoFromJson(Map<String, dynamic> json) =>
    UpdateFavoriteDto(
      status: $enumDecodeNullable(_$FavoriteStatusEnumMap, json['status']),
      personalRating: (json['personal_rating'] as num?)?.toInt(),
      personalComment: json['personal_comment'] as String?,
      watchedAt: json['watched_at'] == null
          ? null
          : DateTime.parse(json['watched_at'] as String),
    );

Map<String, dynamic> _$UpdateFavoriteDtoToJson(UpdateFavoriteDto instance) =>
    <String, dynamic>{
      'status': _$FavoriteStatusEnumMap[instance.status],
      'personal_rating': instance.personalRating,
      'personal_comment': instance.personalComment,
      'watched_at': instance.watchedAt?.toIso8601String(),
    };
