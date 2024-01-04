import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie.dart';

abstract class MovieRepository{

  Future<Either<Movie,AppException>> getTrendingMovies();
  Future<Either<Movie,AppException>> getPopularMovies();
  Future<Either<Movie,AppException>> getTopRatedMovies();

}