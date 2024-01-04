import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/data/data_sources/movie_remote_source.dart';
import 'package:movie_app/domain/entity/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository{

  final MovieRemoteResources movieRemoteResources;

  MovieRepositoryImpl({required this.movieRemoteResources});

  @override
  Future<Either<Movie, AppException>> getPopularMovies() async {
    try{
    final response = await movieRemoteResources.getPopularMovie();
    return Left(response);
    }catch(err){
      return Right(GeneralException(message: "Something went wrong $err"));
    }
  }

  @override
  Future<Either<Movie, AppException>> getTrendingMovies() async {
    try{
      final response = await movieRemoteResources.getTendingMovies();
      return Left(response);
    }catch(err){
      return Right(GeneralException(message: "Something went wrong $err"));
    }
  }

  @override
  Future<Either<Movie, AppException>> getTopRatedMovies() async {
    try{
      final response = await movieRemoteResources.getTopRatedMovies();
      return Left(response);
    }catch(err){
      return Right(GeneralException(message: "Something went wrong $err"));
    }
  }

}