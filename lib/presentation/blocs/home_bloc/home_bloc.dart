import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';

import '../../../domain/usecase/trending_movie_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TrendingMovieUseCase trendingMovieUseCase;
  List<ResultsEntity> movieTrendingList = [];

  HomeBloc({required this.trendingMovieUseCase}) : super(HomeMovieTrendingLoading())
  {
    on<CallTrendingMoviesApiEvent>((event, emit) => getTrendingMovies(event, emit),);
  }

  Future<void> getTrendingMovies(HomeEvent event, Emitter<HomeState> emit) async {
    final results = await trendingMovieUseCase.getAllTrendingMovies(url: ApiConfig.tredingMovieUrl);
    results.fold((response) {
      debugPrint("Trending Movie Response ${response.results!.first.title.toString()}");
      movieTrendingList.addAll(response!.results!);
      emit(HomeMovieTrendingResponse(trendingMovieEntity: response,
          movieTrendingList: movieTrendingList
      ));
    }, (error) {
      emit(HomeMovieTrendingError());
    });
  }
}
