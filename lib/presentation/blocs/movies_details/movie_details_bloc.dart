import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie_detail_Entity.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';
import 'package:movie_app/domain/usecase/trending_movie_usecase.dart';
import 'package:video_player/video_player.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final TrendingMovieUseCase trendingMovieUseCase;
  List<ResultsEntity> recommendedMoviesList = [];
  MovieDetailsBloc({required this.trendingMovieUseCase})
      : super((MovieLoading())) {
    on<FetchMovieDetailsFromApiEvent>(_fetchMovieDetailById);
    on<FetchRecommendedMovieEvent>(_fetchRecommendedMovies);
  }

  FutureOr<void> _fetchMovieDetailById(FetchMovieDetailsFromApiEvent event,
      Emitter<MovieDetailsState> emit) async {
    final response =
        await trendingMovieUseCase.getMovieDetailsById(url: event.apiUrl!);
    response.fold((value) {
      emit(MovieDetailResponse(movieDetailEntity: value));
    }, (r) => emit(MovieError(appException: r)));
  }

  FutureOr<void> _fetchRecommendedMovies(
      FetchRecommendedMovieEvent event, Emitter<MovieDetailsState> emit) async {
    emit(LoadinRecommendedMovie());
    final response = await trendingMovieUseCase.getMovies(url: event.apiUrl!);
    response.fold((value) {
      debugPrint(value.results?.length.toString());
      recommendedMoviesList.clear();
      recommendedMoviesList.addAll(value.results ?? []);
      emit(RecommendedMoviesResponse(
          movieData: value, recommendedMoviesList: recommendedMoviesList));
    }, (r) => emit(MovieError(appException: r)));
  }
}
