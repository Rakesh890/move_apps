import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/repository/watchlist_repository.dart';

import '../../core/error/app_exception.dart';

class WatchListUseCase {
  final MovieWatchListRepository watchListRepository;

  WatchListUseCase({required this.watchListRepository});

  FutureOr<Either<dynamic, AppException>> addMovieInWatchList(
      {required String url, required Map<String, dynamic> bodyRequest}) async {
    final result = await watchListRepository.addMovieInWatchList(
        url: url, bodyRequest: bodyRequest);
    return result;
  }

  FutureOr<Either<MovieEntity, AppException>> getMovieWatchListData(
      {required String url}) async {
    final result = await watchListRepository.getMovieWatchList(url: url);
    return result;
  }
}
