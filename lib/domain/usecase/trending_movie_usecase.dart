import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';
import 'package:movie_app/domain/repository/trending_movie_repository.dart';
import 'package:dartz/dartz.dart';

class TrendingMovieUseCase{
  final TrendingMovieRepository trendingMovieRepository;

  TrendingMovieUseCase({required this.trendingMovieRepository});

  Future<Either<TrendingMovieEntity, AppException>> getAllTrendingMovies(
      {required String url}) async {
    final response = await trendingMovieRepository.getAllTrendingMovies(url: url);
    return response;
  }
}