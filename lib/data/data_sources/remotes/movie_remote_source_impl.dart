import 'package:dio/dio.dart';
import 'package:movie_app/core/error/server_exception.dart';
import 'package:movie_app/data/data_sources/movie_remote_source.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/entity/movie.dart';

class MovieRemoteSourceImpl implements MovieRemoteResources{
  final Dio client;
  final String baseUrl = "https://api.themoviedb.org/3";
  final  String apiKey = "99f9593c83db3ccbd04f99820786dab3";

  MovieRemoteSourceImpl({
    required this.client
    });

  @override
  Future<Movie> getTendingMovies() async {
   final response = await client.get("$baseUrl/trending/all/week?language=en-US&api_key=$apiKey");
   if(response.statusCode == 200){
    return MovieModels.fromJson(response.data);
   }else{
     throw ServerException(message: response.data.toString());
   }
    
  }

  @override
  Future<Movie> getPopularMovie() async {
      final response = await client.get("$baseUrl/movie/popular?api_key=$apiKey");
    if(response.statusCode == 200){
      return MovieModels.fromJson(response.data);
    }else{
      throw ServerException(message: response.data.toString());
    }
  }

  @override
  Future<Movie> getTopRatedMovies() async {
    final response = await client.get("$baseUrl/movie/top_rated?api_key=$apiKey");
    if(response.statusCode == 200){
      return MovieModels.fromJson(response.data);
    }else{
      throw ServerException(message: response.data.toString());
    }
  }





}