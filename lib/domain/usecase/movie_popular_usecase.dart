import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class MoviePopularUseCase{
  final MovieRepository movieRepository;

  MoviePopularUseCase({required this.movieRepository});

  Future<Either<Movie,AppException>> call() async {
    final result = await movieRepository.getPopularMovies();
    return result;
  }
}