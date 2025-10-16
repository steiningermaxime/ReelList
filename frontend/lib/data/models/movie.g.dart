// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  tmdbId: (json['id'] as num).toInt(),
  title: json['title'] as String,
  posterPath: json['poster_path'] as String?,
  overview: json['overview'] as String?,
  releaseDate: json['release_date'] as String?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'id': instance.tmdbId,
  'title': instance.title,
  'poster_path': instance.posterPath,
  'overview': instance.overview,
  'release_date': instance.releaseDate,
  'vote_average': instance.voteAverage,
};
