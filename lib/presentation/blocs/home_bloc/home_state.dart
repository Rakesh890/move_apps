part of 'home_bloc.dart';

abstract class HomeState {}

class HomeMovieTrendingLoading extends HomeState {}

class HomeMovieTrendingResponse extends HomeState {
  MovieEntity trendingMovieEntity;
  List<ResultsEntity> movieTrendingList = [];
  List<ResultsEntity> nowPlayingList = [];
  List<ResultsEntity> topRatedMoviesList = [];
  List<ResultsEntity> popularMovieList = [];
  HomeMovieTrendingResponse(
      {required this.trendingMovieEntity,
      required this.movieTrendingList,
      required this.nowPlayingList,
      required this.popularMovieList,
      required this.topRatedMoviesList});
}

class HomeMovieTrendingError extends HomeState {
  HomeMovieTrendingError();
}

class UserApiLoading extends HomeState {}

class UserResponse extends HomeState {
  final UserInfoEntity userInfoEntity;

  UserResponse({required this.userInfoEntity});
}

class UserError extends HomeState {}
