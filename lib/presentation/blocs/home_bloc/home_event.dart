part of 'home_bloc.dart';

abstract class HomeEvent {}

class CallTrendingMoviesApiEvent extends HomeEvent {}

class FetchNowPlayingMovieEvent extends HomeEvent {}

class CallUserInfoApiEvent extends HomeEvent {}
