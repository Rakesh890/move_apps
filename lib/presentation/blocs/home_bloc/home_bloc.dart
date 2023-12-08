import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';

import '../../../domain/usecase/trending_movie_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TrendingMovieUseCase trendingMovieUseCase;
  List<ResultsEntity> movieTrendingList = [];
  List<ResultsEntity> nowPlayingMovies = [];
  List<ResultsEntity> topRatedMoviesList = [];
  List<ResultsEntity> popularMovieList = [];

  HomeBloc({required this.trendingMovieUseCase}) : super(HomeMovieTrendingLoading())
  {
    on<CallTrendingMoviesApiEvent>(_fetchData);
  }


  // Future<void> getTrendingMovies(HomeEvent event, Emitter<HomeState> emit) async {
  //   final results = await trendingMovieUseCase.getAllTrendingMovies(url: ApiConfig.tredingMovieUrl);
  //   results.fold((response) {
  //     movieTrendingList.addAll(response!.results!);
  //     emit(HomeMovieTrendingResponse(trendingMovieEntity: response,
  //         movieTrendingList: movieTrendingList
  //     ));
  //   }, (error) {
  //     emit(HomeMovieTrendingError());
  //   });
  // }
  //
  // Future<void> getPlayingMovie(HomeEvent event, Emitter<HomeState> emit) async {
  //   final results = await trendingMovieUseCase.getAllTrendingMovies(url: ApiConfig.nowPlayingMovieUrl);
  //   results.fold((response) {
  //     debugPrint("Now Playing ${response.results!.first.title.toString()}");
  //     nowPlayingMovies.addAll(response!.results!);
  //     emit(HomeNowPlayingResponse(nowPlayingList:nowPlayingMovies, trendingMovieEntity: response));
  //   }, (error) {
  //     emit(HomeNowPlayingMovieError());
  //   });
  // }

  ///Execute All api as parally
  Future<void> _fetchData(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      final List<Either<TrendingMovieEntity,AppException>> results = await Future.wait([
      trendingMovieUseCase.getMovies(url: ApiConfig.tredingMovieUrl),//Trending
      trendingMovieUseCase.getMovies(url: ApiConfig.nowPlayingMovieUrl),//Now playing
      trendingMovieUseCase.getMovies(url: ApiConfig.topRateedMoviesUrll),//Top Rated
      trendingMovieUseCase.getMovies(url: ApiConfig.mostPopularMovieUrl),//Popular Movies
      ]);

      Either<TrendingMovieEntity,AppException> trendingResponse = results[0];
      Either<TrendingMovieEntity,AppException> nowPlayingResponse = results[1];
      Either<TrendingMovieEntity,AppException> topRatedMovieResponse = results[2];
      Either<TrendingMovieEntity,AppException> mostPopularMovieResponse = results[3];

      ///Get First Trending Response
      trendingResponse.fold((results) {
        movieTrendingList.clear();
        movieTrendingList.addAll(results.results!);
          emit(HomeMovieTrendingResponse(
            movieTrendingList: movieTrendingList,
            trendingMovieEntity: results,
            nowPlayingList: nowPlayingMovies,
          popularMovieList: popularMovieList,
          topRatedMoviesList: topRatedMoviesList));
            }, (r) => emit(HomeMovieTrendingError()));
      ///Now playing Releated Movies data got it
      nowPlayingResponse.fold((results) {
        nowPlayingMovies.clear();
        nowPlayingMovies.addAll(results.results!);
        emit(HomeMovieTrendingResponse(
          movieTrendingList: movieTrendingList,
          trendingMovieEntity: results,
          nowPlayingList: nowPlayingMovies,
            popularMovieList: popularMovieList,
            topRatedMoviesList: topRatedMoviesList
        ));}, (r) => emit(HomeMovieTrendingError()));

      ///topRatedMovieResponse Movies data got it
      topRatedMovieResponse.fold((results) {
        topRatedMoviesList.clear();
        topRatedMoviesList.addAll(results.results!);
        emit(HomeMovieTrendingResponse(
            movieTrendingList: movieTrendingList,
            trendingMovieEntity: results,
            nowPlayingList: nowPlayingMovies,
            popularMovieList: popularMovieList,
            topRatedMoviesList: topRatedMoviesList
        ));}, (r) => emit(HomeMovieTrendingError()));


      ///mostPopularMovieResponse Movies data got it
      mostPopularMovieResponse.fold((results) {
        popularMovieList.clear();
        popularMovieList.addAll(results.results!);
        emit(HomeMovieTrendingResponse(
            movieTrendingList: movieTrendingList,
            trendingMovieEntity: results,
            nowPlayingList: nowPlayingMovies,
            popularMovieList: popularMovieList,
            topRatedMoviesList: topRatedMoviesList
        ));}, (r) => emit(HomeMovieTrendingError()));



    } catch (error) {
      emit(HomeMovieTrendingError());
    }
  }
}
