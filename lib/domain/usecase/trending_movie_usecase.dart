import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie_detail_Entity.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';
import 'package:movie_app/domain/repository/trending_movie_repository.dart';
import 'package:dartz/dartz.dart';

class TrendingMovieUseCase{
  final TrendingMovieRepository trendingMovieRepository;

  TrendingMovieUseCase({required this.trendingMovieRepository});

  Future<Either<TrendingMovieEntity, AppException>> getMovies(
      {required String url}) async {
    final response = await trendingMovieRepository.getMovies(url: url);
    return response;
  }
  Future<Either<MovieDetailEntity, AppException>> getMovieDetailsById(
      {required String url}) async {
    final response = await trendingMovieRepository.getMovieInfo(url: url);
    return response;
  }
}