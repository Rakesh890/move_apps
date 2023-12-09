import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/blocs/landing/landing_bloc.dart';
import 'package:movie_app/presentation/pages/home.dart';
import 'package:movie_app/presentation/pages/my_movies.dart';
import 'package:movie_app/utils/app_colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        return Scaffold(
            body: IndexedStack(
              index: state.tabIndex,
              children: const [HomePage(), MyMoviesPage()],
            ),
            bottomNavigationBar: ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 100, sigmaY: 200, tileMode: TileMode.mirror),
                  child: BottomNavigationBar(
                      selectedIconTheme:
                          const IconThemeData(color: Colors.white),
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.grey),
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.grey,
                      currentIndex: state.tabIndex,
                      onTap: (values) {
                        BlocProvider.of<LandingBloc>(context)
                            .add(BottomTabChanges(tabIndex: values));
                      },
                      backgroundColor: Colors.black54.withOpacity(0.10),
                      type: BottomNavigationBarType.fixed,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: "My Profile",
                        ),
                      ])),
            ));
      },
    );
  }
}
