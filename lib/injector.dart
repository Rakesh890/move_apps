import 'package:get_it/get_it.dart';
import 'package:movie_app/data/data_sources/newtwork/api_service.dart';
import 'package:movie_app/data/repository/movie_impl.dart';
import 'package:movie_app/data/repository/user_impl.dart';
import 'package:movie_app/data/repository/watchlist_impl.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/domain/repository/user_repository.dart';
import 'package:movie_app/domain/repository/watchlist_repository.dart';
import 'package:movie_app/domain/usecase/movie_usecase.dart';
import 'package:movie_app/domain/usecase/user_usecase.dart';
import 'package:movie_app/domain/usecase/watchlist_usecase.dart';
import 'package:movie_app/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:movie_app/presentation/blocs/landing/landing_bloc.dart';
import 'package:movie_app/presentation/blocs/movies_details/movie_details_bloc.dart';
import 'package:movie_app/presentation/blocs/my_movies/my_movies_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initInjectors() async {
  //Bloc service
  serviceLocator.registerFactory(() => HomeBloc(
      trendingMovieUseCase: serviceLocator(), userUseCase: serviceLocator()));
  serviceLocator.registerFactory(() => MovieDetailsBloc(
      trendingMovieUseCase: serviceLocator(),
      watchListUseCase: serviceLocator()));
  serviceLocator.registerLazySingleton(() => LandingBloc());
  serviceLocator.registerFactory(() => MyMoviesBloc(watchListUseCase: serviceLocator()));

  //UseCase (domain layer)
  serviceLocator.registerFactory(
      () => MovieUseCase(trendingMovieRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => UserUseCase(userRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => WatchListUseCase(watchListRepository: serviceLocator()));

  //Repository Impl
  serviceLocator.registerFactory<MovieRepository>(
      () => TrendingMovieImpl(apiProvider: serviceLocator()));
  serviceLocator.registerFactory<UserRepository>(
      () => UserImpl(apiProvider: serviceLocator()));
  serviceLocator.registerFactory<MovieWatchListRepository>(
      () => MovieWathcListImpl(apiProvider: serviceLocator()));

  //Other Service
  serviceLocator.registerFactory<ApiProvider>(() => ApiProvider());
}
