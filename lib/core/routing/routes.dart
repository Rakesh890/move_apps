import 'package:flutter/material.dart';
import 'package:movie_app/presentation/pages/home.dart';
import 'package:movie_app/presentation/pages/landing.dart';
import 'package:movie_app/presentation/pages/movie_details.dart';
import 'package:movie_app/presentation/pages/my_movies.dart';

class Routes {
  static const String home = '/home';
  static const String landing = '/landing';
  static const String movies = '/movies';
  static const String moviesDetail = '/movies_detail';

  static Route<String> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case movies:
        return MaterialPageRoute(builder: (_) => const MyMoviesPage());
      case moviesDetail:
        return MaterialPageRoute(builder: (_) => const MoviesDetailsPage());
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      default:
        return MaterialPageRoute(builder: (_) => const LandingPage());
    }
  }
}
