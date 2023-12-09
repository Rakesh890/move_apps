part of 'my_movies_bloc.dart';

@immutable
abstract class MyMoviesState {}

class MyMoviesInitial extends MyMoviesState {}

class MyMovieWatchListResponse extends MyMoviesState {
  final MovieEntity movieEntity;

  MyMovieWatchListResponse({required this.movieEntity});
}

class MyMovieWatchListError extends MyMoviesState {
  MyMovieWatchListError(AppException r);
}
