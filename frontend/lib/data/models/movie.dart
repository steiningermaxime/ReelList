import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id')
  final int tmdbId;
  final String title;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  final String? overview;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  Movie({
    required this.tmdbId,
    required this.title,
    this.posterPath,
    this.overview,
    this.releaseDate,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  String? get posterUrl {
    if (posterPath == null) return null;
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  int? get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) return null;
    try {
      return int.parse(releaseDate!.split('-')[0]);
    } catch (e) {
      return null;
    }
  }
}