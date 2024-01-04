part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HLoadingMovie extends HomeState{}

class HMovieResponse extends HomeState{
  final List<ResultsEntity> trendingMovie;
  final List<ResultsEntity> popularMovie;
  final List<ResultsEntity> topRatedMovies;
  HMovieResponse({required this.trendingMovie,required this.popularMovie,required this.topRatedMovies});
}

class HMovieError extends HomeState{}

class HScrolledState extends HomeState{
  final int index ;
  HScrolledState(this.index);
}