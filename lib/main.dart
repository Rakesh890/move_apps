import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:movie_app/presentation/blocs/landing/landing_bloc.dart';
import 'package:movie_app/presentation/blocs/movies_details/movie_details_bloc.dart';
import 'core/routing/routes.dart';
import 'package:movie_app/injector.dart' as di;

void main() async {
 await di.initInjectors();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LandingBloc(),),
        BlocProvider(create: (context) => HomeBloc(trendingMovieUseCase: serviceLocator(),
        userUseCase: serviceLocator()),),
        BlocProvider(create: (context) => MovieDetailsBloc(trendingMovieUseCase: serviceLocator(),watchListUseCase: serviceLocator()),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(useMaterial3: true,),
        theme: ThemeData(
            useMaterial3: true, scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        )),
        initialRoute: Routes.landing,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
