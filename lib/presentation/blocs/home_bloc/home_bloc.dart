import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/entity/user_info_entity.dart';
import 'package:movie_app/domain/usecase/user_usecase.dart';

import '../../../domain/usecase/movie_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieUseCase trendingMovieUseCase;
  final UserUseCase userUseCase;

  List<ResultsEntity> movieTrendingList = [];
  List<ResultsEntity> nowPlayingMovies = [];
  List<ResultsEntity> topRatedMoviesList = [];
  List<ResultsEntity> popularMovieList = [];

  HomeBloc({required this.trendingMovieUseCase, required this.userUseCase})
      : super(HomeMovieTrendingLoading()) {
    on<CallUserInfoApiEvent>(_fetchUserInfo);
    on<CallTrendingMoviesApiEvent>(_fetchData);
  }

  ///Execute All api as parally
  Future<void> _fetchData(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      final List<Either<MovieEntity, AppException>> results =
          await Future.wait([
        trendingMovieUseCase.getMovies(
            url: ApiConfig.tredingMovieUrl), //Trending
        trendingMovieUseCase.getMovies(
            url: ApiConfig.nowPlayingMovieUrl), //Now playing
        trendingMovieUseCase.getMovies(
            url: ApiConfig.topRateedMoviesUrll), //Top Rated
        trendingMovieUseCase.getMovies(url: ApiConfig.mostPopularMovieUrl),
        //Popular Movies
      ]);

      Either<MovieEntity, AppException> trendingResponse = results[0];
      Either<MovieEntity, AppException> nowPlayingResponse = results[1];
      Either<MovieEntity, AppException> topRatedMovieResponse = results[2];
      Either<MovieEntity, AppException> mostPopularMovieResponse = results[3];

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
            topRatedMoviesList: topRatedMoviesList));
      }, (r) => emit(HomeMovieTrendingError()));

      ///topRatedMovieResponse Movies data got it
      topRatedMovieResponse.fold((results) {
        topRatedMoviesList.clear();
        topRatedMoviesList.addAll(results.results!);
        emit(HomeMovieTrendingResponse(
            movieTrendingList: movieTrendingList,
            trendingMovieEntity: results,
            nowPlayingList: nowPlayingMovies,
            popularMovieList: popularMovieList,
            topRatedMoviesList: topRatedMoviesList));
      }, (r) => emit(HomeMovieTrendingError()));

      ///mostPopularMovieResponse Movies data got it
      mostPopularMovieResponse.fold((results) {
        popularMovieList.clear();
        popularMovieList.addAll(results.results!);
        emit(HomeMovieTrendingResponse(
            movieTrendingList: movieTrendingList,
            trendingMovieEntity: results,
            nowPlayingList: nowPlayingMovies,
            popularMovieList: popularMovieList,
            topRatedMoviesList: topRatedMoviesList));
      }, (r) => emit(HomeMovieTrendingError()));
    } catch (error) {
      emit(HomeMovieTrendingError());
    }
  }

  FutureOr<void> _fetchUserInfo(event, Emitter<HomeState> emit) async {
    emit(UserApiLoading());
    try {
      final userData =
          await userUseCase.getUserInfo(url: ApiConfig.accountDetailsUrl);
      userData.fold((data) {
        emit(UserResponse(userInfoEntity: data));
      }, (error) => emit(UserError()));
    } catch (err) {
      emit(UserError());
    }
  }
}
