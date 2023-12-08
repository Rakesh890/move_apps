class ApiConfig{
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "99f9593c83db3ccbd04f99820786dab3";
  static const String accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OWY5NTkzYzgzZGIzY2NiZDA0Zjk5ODIwNzg2ZGFiMyIsInN1YiI6IjY1NzE2ODA0ZGZlMzFkMDBjM2NkZWJkNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wiiaRX8-3oC4vHc8ryU4cYjW-PVNVqKCvod5umsBrUs";
  static const String imageUrl = "https://image.tmdb.org/t/p/";

  //
  static const String getAllMoviesUrl = "";
  static const String getMovieDetailUrl = "";
  static const String tredingMovieUrl = "$baseUrl/trending/all/week?language=en-US&api_key=$apiKey";
  static const String nowPlayingMovieUrl = "$baseUrl/movie/now_playing?api_key=$apiKey";
  static const String topRateedMoviesUrll ="$baseUrl/movie/top_rated?api_key=$apiKey";
  static const String mostPopularMovieUrl ="$baseUrl/movie/popular?api_key=$apiKey";
  static const String movieDetails = "$baseUrl/movie/";
  static const String recommedMoviesUrl = "$baseUrl/movie/";


}