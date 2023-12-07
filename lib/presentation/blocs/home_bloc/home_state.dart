part of 'home_bloc.dart';

abstract class HomeState {}

class HomeMovieTrendingLoading extends HomeState {}

class DataLoaded extends HomeState{}

class HomeMovieTrendingResponse extends HomeState {
  TrendingMovieEntity trendingMovieEntity;
  List<ResultsEntity> movieTrendingList = [];
  HomeMovieTrendingResponse({required this.trendingMovieEntity,
    required this.movieTrendingList
  });
}
class HomeMovieTrendingError extends HomeState {
  HomeMovieTrendingError();
}


