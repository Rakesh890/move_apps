import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/routing/routes.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:movie_app/presentation/widgets/movie_tile.dart';
import 'package:movie_app/utils/extensions/sized_box_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloc = serviceLocator.get<HomeBloc>();
  @override
  void initState() {
    super.initState();
    homeBloc.add(CallTrendingMoviesApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.30),
        elevation: 10,
        leading: const SizedBox(),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  debugPrint(state.runtimeType.toString());
                  if (state is HomeMovieTrendingResponse) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildViewMovieSections(moviesList: state.movieTrendingList, headingOfSectionName: "Trending Movie's"),
                          10.h,
                          buildViewMovieSections(moviesList: state.topRatedMoviesList, headingOfSectionName: "Top Rated Movie's"),
                          10.h,
                          buildViewMovieSections(moviesList: state.popularMovieList, headingOfSectionName: "Most Popular Movie's"),
                          10.h,
                          buildViewMovieSections(moviesList: state.nowPlayingList, headingOfSectionName: "Now Playing Movie's"),
                        ],
                      ),
                    );
                  } else if (state is HomeMovieTrendingError) {
                    return const Center(
                      child: Text(
                        "Error Occure",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                bloc: homeBloc),
          ],
        ),
      )),
    );
  }

  Widget buildViewMovieSections({required List<ResultsEntity> moviesList,required String headingOfSectionName}) {
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
