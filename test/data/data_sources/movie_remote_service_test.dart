import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/data/data_sources/movie_remote_source.dart';
import 'package:movie_app/data/data_sources/remotes/movie_remote_source_impl.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/domain/entity/movie.dart';

import 'movie_remote_service_test.mocks.dart';

@GenerateMocks([Dio])
final String baseUrl = "https://api.themoviedb.org/3";
final String apiKey = "99f9593c83db3ccbd04f99820786dab3";

void main() {
  late MovieRemoteResources movieRemoteResources;
  late MockDio dio;

  // Define sample data or responses


  Map<String,dynamic> sampleApiResponse =
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "id": 1,
      "title": "Sample Movie",
      "original_language": "en",
      "original_title": "Sample Movie",
      "overview": "Overview here",
      "poster_path": "/path2.jpg",
      "media_type": "movie",
      "genre_ids": [1, 2, 3],
      "popularity": 100.0,
      "release_date": "2020-01-01",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 100
    }
  ],
  "total_pages": 1,
  "total_results": 1
};



  group("Movie Remote Service", () {
    setUp(() {
      dio = MockDio();
      movieRemoteResources = MovieRemoteSourceImpl(client: dio);
    });

    test('should perform a GET request on a URL to get trending movies', () async {
      MovieModels models = MovieModels.fromJson(sampleApiResponse);
      Movie movie1 = models;
      // arrange
      when(dio.get("$baseUrl/trending/all/week?language=en-US&api_key=$apiKey"))
          .thenAnswer((_) async =>  Response(
        data: sampleApiResponse,
        statusCode: 200,
        requestOptions: RequestOptions(),
      ));

      // act
     final result =  await movieRemoteResources.getTendingMovies();
      // assert
      verify(dio.get("$baseUrl/trending/all/week?language=en-US&api_key=$apiKey"));
      expect(result, movie1);
    });

    test('should perform a get request on url to get movie popular movies',() async{
      MovieModels models = MovieModels.fromJson(sampleApiResponse);
      Movie movie1 = models;
      //Arrange
      when(dio.get("$baseUrl/movie/popular?api_key=$apiKey")).thenAnswer((realInvocation) async {

        return Response(requestOptions: RequestOptions(),
        statusCode: 200,
        data: sampleApiResponse);

      });

      //Act
      final result = await movieRemoteResources.getPopularMovie();

      //Expect
      verify(dio.get("$baseUrl/movie/popular?api_key=$apiKey"));
      expect(result, movie1);

    });

  });
}
