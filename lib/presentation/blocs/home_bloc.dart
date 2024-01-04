import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie.dart';
import 'package:movie_app/domain/usecase/movie_top_rated.dart';

import '../../domain/usecase/movie_popular_usecase.dart';
import '../../domain/usecase/movie_trending.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieTrendingUseCase movieTrendingUseCase;
  final MoviePopularUseCase popularMovieUseCase;
  final MovieTopRatedUseCase movieTopRatedUseCase;

  List<ResultsEntity> trendingMovie = [];
  List<ResultsEntity> popularMovie = [];
  List<ResultsEntity> topRatedMovies = [];

  HomeBloc(
      {required this.movieTrendingUseCase,
      required this.popularMovieUseCase,
      required this.movieTopRatedUseCase})
      : super(HomeInitial()) {
    on<FetchMoviesEvent>(_fetchMovies);
  }

  //Parallel Execution of api's
  FutureOr<void> _fetchMovies(
      FetchMoviesEvent event, Emitter<HomeState> emit) async {
    emit(HLoadingMovie());
    final List<Either<Movie, AppException>> response = await Future.wait([
      movieTrendingUseCase.call(),
      popularMovieUseCase.call(),
      movieTopRatedUseCase.call()
    ]);
    response[0].fold(
        (result) => emit(HMovieResponse(
            trendingMovie: (trendingMovie..addAll(result.results!)),
            popularMovie: popularMovie,
            topRatedMovies: topRatedMovies)),
        (r) => emit(HMovieError()));

    response[1].fold(
        (result) => emit(HMovieResponse(
            trendingMovie: trendingMovie,
            popularMovie: popularMovie..addAll(result.results!),
            topRatedMovies: topRatedMovies)),
        (r) => emit(HMovieError()));

    response[2].fold(
        (result) => emit(HMovieResponse(
            trendingMovie: trendingMovie,
            popularMovie: popularMovie,
            topRatedMovies: topRatedMovies..addAll(result.results!))),
        (r) => emit(HMovieError()));
  }

  FutureOr<void> onScroll(
      CarosuleScrollingEvent event, Emitter<HomeState> emit) {
    debugPrint(event.index.toString());
    emit(HScrolledState(event.index));
  }
}
