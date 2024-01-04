import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final int? page;
  final List<ResultsEntity>? results;
  final int? totalPages;
  final int? totalResults;

  Movie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
    page,
    results,
    totalPages,
    totalResults,
  ];

}

class ResultsEntity extends Equatable{
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final String? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const ResultsEntity({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    id,
    title,
    originalLanguage,
    originalTitle,
    overview,
    posterPath,
    mediaType,
    genreIds,
    popularity,
    releaseDate,
    video,
    voteAverage,
    voteCount,
  ];

}