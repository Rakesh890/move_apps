part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsEvent {}

class FetchMovieDetailsFromApiEvent extends MovieDetailsEvent{
 final String? apiUrl;
  FetchMovieDetailsFromApiEvent({required this.apiUrl});
}

class FetchRecommendedMovieEvent extends MovieDetailsEvent{
 final String? apiUrl;
 FetchRecommendedMovieEvent({required this.apiUrl});
}

class InitVideoPlayerEvent extends MovieDetailsEvent{
 final String videoUrl;
 InitVideoPlayerEvent({required this.videoUrl});
}