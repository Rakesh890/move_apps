import 'package:get_it/get_it.dart';
import 'package:movie_app/data/data_sources/newtwork/api_service.dart';
import 'package:movie_app/data/repository/trending_movie_impl.dart';
import 'package:movie_app/domain/repository/trending_movie_repository.dart';
import 'package:movie_app/domain/usecase/trending_movie_usecase.dart';
import 'package:movie_app/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:movie_app/presentation/blocs/landing/landing_bloc.dart';
import 'package:movie_app/presentation/blocs/movies_details/movie_details_bloc.dart';



final serviceLocator = GetIt.instance;

Future<void> initInjectors() async {
  //Bloc service
  serviceLocator.registerFactory(() => HomeBloc(trendingMovieUseCase: serviceLocator()));
  serviceLocator.registerFactory(() => MovieDetailsBloc(trendingMovieUseCase: serviceLocator()));
  serviceLocator.registerLazySingleton(() => LandingBloc());

  //UseCase (domain layer)
  serviceLocator.registerFactory(
          () => TrendingMovieUseCase(trendingMovieRepository: serviceLocator()));
  //Repository Impl
  serviceLocator.registerFactory<TrendingMovieRepository>(() => TrendingMovieImpl(apiProvider: serviceLocator()));
  //Network Service
  serviceLocator.registerFactory<ApiProvider>(() => ApiProvider());

}
