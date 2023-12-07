import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';

class TrendingMovieModels extends TrendingMovieEntity with EquatableMixin{

  final int? page;

  final List<Results>? results;

  final int? totalPages;

  final int? totalResults;

  TrendingMovieModels({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TrendingMovieModels.fromJson(Map<String, dynamic> json){
    return TrendingMovieModels(
        page : json['page'] as int?,
        results: (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList(),
        totalPages : json['total_pages'] as int?,
        totalResults : json['total_results'] as int?
    );
  }


}

class Results extends ResultsEntity with EquatableMixin {
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

  Results({
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

 factory Results.fromJson(Map<String, dynamic> json){
   return Results(
       adult:json['adult'] as bool?,
       backdropPath : json['backdrop_path'] as String?,
       id : json['id'] as int?,
       title : json['title'] as String?,
       originalLanguage : json['original_language'] as String?,
       originalTitle : json['original_title'] as String?,
       overview : json['overview'] as String?,
       posterPath : json['poster_path'] as String?,
       mediaType : json['media_type'] as String?,
       genreIds : (json['genre_ids'] as List?)?.map((dynamic e) => e as int).toList(),
       popularity : json['popularity'] as double?,
       releaseDate : json['release_date'] as String?,
       video : json['video'] as bool?,
       voteAverage : json['vote_average'] as double?,
       voteCount : json['vote_count'] as int?
   );
 }

}