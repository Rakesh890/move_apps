import 'package:movie_app/domain/entity/movie.dart';

abstract class MovieRemoteResources{

  Future<Movie> getTendingMovies();

  Future<Movie> getPopularMovie();

  Future<Movie> getTopRatedMovies();

}