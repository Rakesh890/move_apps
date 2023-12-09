// ignore_for_file: must_be_immutable

part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieLoading extends MovieDetailsState {}

class MovieDetailResponse extends MovieDetailsState {
  final MovieDetailEntity movieDetailEntity;
  MovieDetailResponse({required this.movieDetailEntity});
}

class LoadinRecommendedMovie extends MovieDetailsState {}

class RecommendedMoviesResponse extends MovieDetailsState {
  final List<ResultsEntity> recommendedMoviesList;
  final MovieEntity movieData;
  RecommendedMoviesResponse(
      {required this.recommendedMoviesList, required this.movieData});
}

class MovieError extends MovieDetailsState {
  final AppException appException;
  MovieError({required this.appException});
}

class VideoInitial extends MovieDetailsState {}

class VideoInitialized extends MovieDetailsState {
  final VideoPlayerController controller;
  VideoInitialized(this.controller);
}

class VideoPlayed extends MovieDetailsState {}

class VideoPause extends MovieDetailsState {}

class InitialMovieNotAddedOnWathcList extends MovieDetailsState {
  bool isAddedToWatchLis;
  InitialMovieNotAddedOnWathcList({required this.isAddedToWatchLis});
}

class AddedMovieInWatchList extends MovieDetailsState {
  bool isAddedToWatchLis;
  AddedMovieInWatchList({required this.isAddedToWatchLis});
}

class NotAddedMovieInWatchList extends MovieDetailsState{
   bool isAddedToWatchLis;
  NotAddedMovieInWatchList({required this.isAddedToWatchLis});
}
