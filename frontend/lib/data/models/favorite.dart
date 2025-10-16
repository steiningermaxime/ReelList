import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

enum FavoriteStatus {
  @JsonValue('watchlist')
  watchlist,
  @JsonValue('watched')
  watched,
}

@JsonSerializable()
class Favorite {
  final String id;
  @JsonKey(name: 'tmdb_id')
  final int tmdbId;
  final String title;
  @JsonKey(name: 'poster_url')
  final String? posterUrl;
  final String? overview;
  @JsonKey(name: 'release_year')
  final int? releaseYear;
  final FavoriteStatus status;
  @JsonKey(name: 'personal_rating')
  final int? personalRating;
  @JsonKey(name: 'personal_comment')
  final String? personalComment;
  @JsonKey(name: 'added_at')
  final DateTime addedAt;
  @JsonKey(name: 'watched_at')
  final DateTime? watchedAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Favorite({
    required this.id,
    required this.tmdbId,
    required this.title,
    this.posterUrl,
    this.overview,
    this.releaseYear,
    required this.status,
    this.personalRating,
    this.personalComment,
    required this.addedAt,
    this.watchedAt,
    this.updatedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);

  Favorite copyWith({
    String? id,
    int? tmdbId,
    String? title,
    String? posterUrl,
    String? overview,
    int? releaseYear,
    FavoriteStatus? status,
    int? personalRating,
    String? personalComment,
    DateTime? addedAt,
    DateTime? watchedAt,
    DateTime? updatedAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      tmdbId: tmdbId ?? this.tmdbId,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      overview: overview ?? this.overview,
      releaseYear: releaseYear ?? this.releaseYear,
      status: status ?? this.status,
      personalRating: personalRating ?? this.personalRating,
      personalComment: personalComment ?? this.personalComment,
      addedAt: addedAt ?? this.addedAt,
      watchedAt: watchedAt ?? this.watchedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable()
class CreateFavoriteDto {
  @JsonKey(name: 'tmdb_id')
  final int tmdbId;
  final String title;
  @JsonKey(name: 'poster_url')
  final String? posterUrl;
  final String? overview;
  @JsonKey(name: 'release_year')
  final int? releaseYear;
  final FavoriteStatus status;
  @JsonKey(name: 'personal_rating')
  final int? personalRating;
  @JsonKey(name: 'personal_comment')
  final String? personalComment;
  @JsonKey(name: 'watched_at')
  final DateTime? watchedAt;

  CreateFavoriteDto({
    required this.tmdbId,
    required this.title,
    this.posterUrl,
    this.overview,
    this.releaseYear,
    required this.status,
    this.personalRating,
    this.personalComment,
    this.watchedAt,
  });

  factory CreateFavoriteDto.fromJson(Map<String, dynamic> json) =>
      _$CreateFavoriteDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateFavoriteDtoToJson(this);
}

@JsonSerializable()
class UpdateFavoriteDto {
  final FavoriteStatus? status;
  @JsonKey(name: 'personal_rating')
  final int? personalRating;
  @JsonKey(name: 'personal_comment')
  final String? personalComment;
  @JsonKey(name: 'watched_at')
  final DateTime? watchedAt;

  UpdateFavoriteDto({
    this.status,
    this.personalRating,
    this.personalComment,
    this.watchedAt,
  });

  factory UpdateFavoriteDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateFavoriteDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateFavoriteDtoToJson(this);
}