part of 'my_movies_bloc.dart';

@immutable
abstract class MyMoviesEvent {}

class MyMovieWatchListApiCalling extends MyMoviesEvent {
  final String url;
  MyMovieWatchListApiCalling({required this.url});
}
