import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:movie_app/presentation/blocs/landing/landing_bloc.dart';
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
        BlocProvider(create: (context) => HomeBloc(trendingMovieUseCase: serviceLocator()),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(useMaterial3: true,),
        theme: ThemeData(
            useMaterial3: true, scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w700),
          titleMedium: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.w500),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        )),
        initialRoute: Routes.landing,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
