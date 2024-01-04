

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/data/data_sources/movie_remote_source.dart';
import 'package:movie_app/data/data_sources/remotes/movie_remote_source_impl.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/domain/usecase/movie_popular_usecase.dart';
import 'package:movie_app/domain/usecase/movie_top_rated.dart';
import 'package:movie_app/domain/usecase/movie_trending.dart';
import 'package:movie_app/presentation/blocs/home_bloc.dart';

final getIt = GetIt.instance;

void setup()  {
  //Blocs
  getIt.registerFactory<HomeBloc>(() => HomeBloc(movieTrendingUseCase: getIt(), popularMovieUseCase: getIt(), movieTopRatedUseCase: getIt()));

  //Use case
  getIt.registerLazySingleton(() => MovieTrendingUseCase(movieRepository: getIt()));
  getIt.registerLazySingleton(() => MoviePopularUseCase(movieRepository: getIt()));
  getIt.registerLazySingleton(() => MovieTopRatedUseCase(movieRepository: getIt()));


  //Implementation of repository to impl
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(movieRemoteResources: getIt()));

  //Sources
  getIt.registerLazySingleton<MovieRemoteResources>(() => MovieRemoteSourceImpl(client: getIt()));

  //Dio Client
  getIt.registerLazySingleton(() => Dio());

}