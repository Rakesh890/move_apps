import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/blocs/my_movies/my_movies_bloc.dart';
import 'package:movie_app/presentation/widgets/custom_appbar.dart';
import 'package:movie_app/utils/extensions/sized_box_extension.dart';

import '../../core/routing/routes.dart';
import '../widgets/movie_tile.dart';

class MyMoviesPage extends StatefulWidget {
  const MyMoviesPage({Key? key}) : super(key: key);

  @override
  State<MyMoviesPage> createState() => _MyMoviesPageState();
}

class _MyMoviesPageState extends State<MyMoviesPage> {
  final movieBloc = serviceLocator<MyMoviesBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBloc.add(MyMovieWatchListApiCalling(url: ApiConfig.allWatchListUrl));
    print("Called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: MyAppbar(
              actionButton: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 32,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 32,
                    ))
              ],
              userName: const Text(
                "Rakesh",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            )),
        body: SafeArea(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 100,
              sigmaY: 100,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      dense: true,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      leading: const Icon(
                        Icons.downloading,
                        color: Colors.white,
                        size: 32,
                      ),
                      trailing: const Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey.shade700),
                    BlocBuilder<MyMoviesBloc, MyMoviesState>(
                        builder: (context, state) {
                          if (state is MyMoviesInitial) {
                            return const CircularProgressIndicator();
                          } else if (state is MyMovieWatchListResponse) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildViewMovieSections(
                                    moviesList: state.movieEntity.results!,
                                    headingOfSectionName: "Watch List"),
                                10.h,
                                buildViewMovieSections(
                                    moviesList: state.movieEntity.results!,
                                    headingOfSectionName: "Recently Watched"),
                                10.h,
                                buildViewMovieSections(
                                    moviesList: state.movieEntity.results!,
                                    headingOfSectionName: "Recently Watched"),
                                10.h,
                                buildViewMovieSections(
                                    moviesList: state.movieEntity.results!,
                                    headingOfSectionName: "Recently Watched")
                              ],
                            );
                          } else if (state is MyMovieWatchListError) {
                            return Text("Something went wrong $state");
                          }
                          return Container();
                        },
                        bloc: movieBloc),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildViewMovieSections(
      {required List<ResultsEntity> moviesList,
      required String headingOfSectionName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headingOfSectionName,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        SizedBox(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              dragStartBehavior: DragStartBehavior.start,
              itemCount: moviesList.length,
              itemBuilder: (context, index) => MovieTile(
                movieTrendingItem: moviesList[index],
                onPress: () {
                  Navigator.pushNamed(context, Routes.moviesDetail,
                      arguments: {"movieId": moviesList[index].id});
                  debugPrint("${moviesList[index].id}");
                },
              ),
            )),
      ],
    );
  }
}
