part of 'home_bloc.dart';

abstract class HomeState {}

class HomeMovieTrendingLoading extends HomeState {}

class HomeMovieTrendingResponse extends HomeState {
  TrendingMovieEntity trendingMovieEntity;
  List<ResultsEntity> movieTrendingList = [];
  List<ResultsEntity> nowPlayingList = [];
  List<ResultsEntity> topRatedMoviesList = [];
  List<ResultsEntity> popularMovieList = [];
  HomeMovieTrendingResponse({required this.trendingMovieEntity,
    required this.movieTrendingList,
    required this.nowPlayingList,
    required this.popularMovieList,
    required this.topRatedMoviesList
  });
}
class HomeMovieTrendingError extends HomeState {
  HomeMovieTrendingError();
}


class LoadingPlayingMovie extends HomeState {}

class HomeNowPlayingResponse extends HomeState {
  TrendingMovieEntity trendingMovieEntity;
  List<ResultsEntity> nowPlayingList = [];
  HomeNowPlayingResponse({required this.trendingMovieEntity,
    required this.nowPlayingList
  });
}
class HomeNowPlayingMovieError extends HomeState {
  HomeNowPlayingMovieError();
}


