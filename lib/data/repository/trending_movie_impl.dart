import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/data/models/trending_movie_models.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';
import 'package:movie_app/domain/repository/trending_movie_repository.dart';
import '../../core/error/error_handling.dart';
import '../data_sources/newtwork/api_service.dart';

class TrendingMovieImpl extends TrendingMovieRepository{
  final ApiProvider apiProvider;
  TrendingMovieImpl({required this.apiProvider});

  @override
  Future<Either<TrendingMovieModels,AppException>> getAllTrendingMovies({required String url}) async {
  try{
    final data = await apiProvider.executeGet(url: url);
    if(data?.statusCode == 200){
      return left(TrendingMovieModels.fromJson(data!.data));
    }else{
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