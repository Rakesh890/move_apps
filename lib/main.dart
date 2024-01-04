import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/routes/routes.dart';
import 'package:movie_app/injector.dart' as di;
import 'package:movie_app/presentation/blocs/home_bloc.dart';

import 'injector.dart';
import 'utils/theme.dart';

void main()  {
  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeBloc>()..add(FetchMoviesEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(useMaterial3: true,),
        theme: ThemeData(
            useMaterial3: true, scaffoldBackgroundColor: Colors.black,
        textTheme: buildTextTheme(),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        )),
        initialRoute: AppRoutes.home,

        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
