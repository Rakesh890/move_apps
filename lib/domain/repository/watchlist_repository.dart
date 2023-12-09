import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';

abstract class MovieWatchListRepository {
  Future<Either<dynamic,AppException>> addMovieInWatchList(
      {required String url, required Map<String, dynamic> bodyRequest});

  Future<Either<MovieEntity,AppException>> getMovieWatchList({required String url});

}
