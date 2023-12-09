import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/usecase/watchlist_usecase.dart';

part 'my_movies_event.dart';
part 'my_movies_state.dart';

class MyMoviesBloc extends Bloc<MyMoviesEvent, MyMoviesState> {
  final WatchListUseCase watchListUseCase;

  MyMoviesBloc({required this.watchListUseCase}) : super(MyMoviesInitial()) {
    on<MyMovieWatchListApiCalling>(_fetchMovieWatchListData);
  }

  FutureOr<void> _fetchMovieWatchListData(
      MyMovieWatchListApiCalling event, Emitter<MyMoviesState> emit) async {
    final result = await watchListUseCase.getMovieWatchListData(url: event.url);
    result.fold((data) => emit(MyMovieWatchListResponse(movieEntity: data)),
        (r) => emit(MyMovieWatchListError(r)));
  }
}
