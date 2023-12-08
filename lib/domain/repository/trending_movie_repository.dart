import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie_detail_Entity.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TrendingMovieRepository{
  Future<Either<TrendingMovieEntity,AppException>> getMovies({required String url});
  Future<Either<MovieDetailEntity,AppException>> getMovieInfo({required String url});
}