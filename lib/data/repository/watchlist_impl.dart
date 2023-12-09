import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/data/data_sources/newtwork/api_service.dart';
import 'package:movie_app/data/models/movie_models.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/repository/watchlist_repository.dart';

import '../../core/error/error_handling.dart';

class MovieWathcListImpl extends MovieWatchListRepository {
  final ApiProvider apiProvider;

  MovieWathcListImpl({required this.apiProvider});

  @override
  Future<Either<dynamic, AppException>> addMovieInWatchList(
      {required String url, required Map<String, dynamic> bodyRequest}) async {
    try {
      final data =
          await apiProvider.executePost(url: url, bodyRequest: bodyRequest);
      if (data?.statusCode == 200 || data?.statusCode == 201) {
        return left(data!.data);
      } else {
        return right(errorParser(result: data!.data));
      }
    } on DioException catch (error) {
      return right(errorParser(result: error.response, error: error));
    } on SocketException catch (e) {
      return right(SocketException());
    } catch (err) {
      return right(GeneralException());
    }
  }

  @override
  Future<Either<MovieEntity, AppException>> getMovieWatchList(
      {required String url}) async {
    try {
      final data = await apiProvider.executeGet(url: url);
      if (data?.statusCode == 200) {
        return left(MovieModels.fromJson(data!.data));
      } else {
        return right(errorParser(result: data!.data));
      }
    } on DioException catch (error) {
      return right(errorParser(result: error.response, error: error));
    } on SocketException catch (e) {
      return right(SocketException());
    } catch (err) {
      return right(GeneralException());
    }
  }
}
