import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/widgets/button_widget.dart';
import 'package:movie_app/presentation/widgets/custom_appbar.dart';
import 'package:movie_app/presentation/widgets/movie_tile.dart';
import 'package:movie_app/utils/extensions/sized_box_extension.dart';
import 'package:movie_app/utils/extensions/time_conversion.dart';
import 'package:video_player/video_player.dart';
import '../../utils/app_colors.dart';
import '../blocs/movies_details/movie_details_bloc.dart';
import '../widgets/glassmorephism_backgroud.dart';

class MoviesDetailsPage extends StatefulWidget {
  final dynamic movieId;
  const MoviesDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MoviesDetailsPage> createState() => _MoviesDetailsPageState();
}

class _MoviesDetailsPageState extends State<MoviesDetailsPage> {
  final movieBloc = serviceLocator<MovieDetailsBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBloc.add(FetchMovieDetailsFromApiEvent(
        apiUrl:
            "${ApiConfig.movieDetails}/${widget.movieId}?${ApiConfig.apiKey}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: MyAppbar(
              userName: const SizedBox(),
              actionButton: const [],
              leadingWidget: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 32,
                  )),
            )),
        body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                    builder: (context, state) {
                      if (state is MovieError) {
                        return const Center(
                          child: Text(
                            "Something went wrong",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        );
                      } else if (state is MovieDetailResponse) {
                        return mainBody(state);
                      }
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    bloc: serviceLocator<MovieDetailsBloc>()
                      ..add(FetchMovieDetailsFromApiEvent(
                          apiUrl:
                              "${ApiConfig.movieDetails}/${widget.movieId}?${ApiConfig.apiKey}")),
                  ),
                  15.h,
                  recommendedView(),
                ],
              ),
            );
          },
        ));
  }

  Widget recommendedView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is LoadinRecommendedMovie) {
            return const SizedBox();
          } else if (state is RecommendedMoviesResponse) {
            debugPrint(state.recommendedMoviesList.length.toString());
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "More Like This",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 140,
                  height: 3,
                  color: AppColors.redColors,
                ),
                20.h,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.recommendedMoviesList
                      .length, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                        child: MovieTile(
                            movieTrendingItem:
                                state.recommendedMoviesList[index],
                            onPress: () {
                              debugPrint("Api Calling");
                              serviceLocator<MovieDetailsBloc>().add(
                                  FetchMovieDetailsFromApiEvent(
                                      apiUrl:
                                          "${ApiConfig.movieDetails}/${state.recommendedMoviesList[index].id}?${ApiConfig.apiKey}"));
                            }));
                  },
                ),
              ],
            );
          } else {
            return const Text("");
          }
        },
        bloc: serviceLocator<MovieDetailsBloc>()
          ..add(FetchRecommendedMovieEvent(
              apiUrl:
                  "${ApiConfig.recommedMoviesUrl}/${widget.movieId}/recommendations?${ApiConfig.apiKey}")),
      ),
    );
  }

  Widget buildVerticalButton(
          {required String name,
          required IconData iconName,
          required Function() onPress}) =>
      GestureDetector(
        onTap: onPress,
        child: SizedBox(
          width: 75,
          height: 75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconName,
                color: Colors.white,
                size: 32,
              ),
              5.h,
              Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      );

  Widget mainBody(MovieDetailResponse movieResponseState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        10.h,

        ///Movie Banner
        CachedNetworkImage(
          placeholder: (context, url) => Image.asset("assets/images/placeholder.png",
              fit: BoxFit.cover),
            errorWidget: (context, url, error) => Image.asset("assets/images/placeholder.png",
                fit: BoxFit.cover),
            imageUrl:
                "${ApiConfig.imageUrl}/w400/${movieResponseState.movieDetailEntity.posterPath}",
            height: 350,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.contain),
        10.h,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ///Movie Name
              Text(
                movieResponseState.movieDetailEntity.title.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),
              5.h,

              ///Popularity and released dated
              RichText(
                text: TextSpan(
                  text:
                      "${movieResponseState.movieDetailEntity.popularity!.floorToDouble() / 10} % match"
                          .toString(),
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          ' ${movieResponseState.movieDetailEntity.releaseDate} ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const TextSpan(
                      text: "${0}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                  ],
                ),
              ),
              10.h,

              ///Play Button
              ButtonWidget(
                onPress: () {},
                buttonName: "Play",
                iconName: Icons.play_arrow_rounded,
                buttonBgColors: Colors.white,
                textColor: Colors.black,
                iconColor: Colors.black,
              ),
              10.h,

              ///Download Button
              ButtonWidget(
                onPress: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("downloading start.."),
                    duration: Duration(seconds: 2),
                  ));
                },
                buttonName: "Download",
                iconName: Icons.file_download,
                buttonBgColors: Colors.grey.shade900,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
              10.h,

              ///Movie Overview
              Text(
                movieResponseState.movieDetailEntity.overview.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0),
              ),
              20.h,

              ///Add my List and Rates,Share Icons Widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: ((context, state) {
                      if (state is AddedMovieInWatchList) {
                        return buildVerticalButton(
                            iconName: Icons.check,
                            name: "Done",
                            onPress: () {});
                      }
                      return buildVerticalButton(
                          iconName: Icons.add,
                          name: "My List",
                          onPress: () {
                            serviceLocator<MovieDetailsBloc>().add(
                                AddMovieInWatchListEvent(
                                    url: ApiConfig.addWatchMoveInWatchlist,
                                    bodyRequest: {
                                  "media_type": "movie",
                                  "media_id":
                                      movieResponseState.movieDetailEntity.id,
                                  "watchlist": true
                                }));
                          });
                    }),
                    bloc: serviceLocator<MovieDetailsBloc>(),
                  ),
                  buildVerticalButton(
                      iconName: Icons.thumb_up_alt_outlined,
                      name: "Rate",
                      onPress: () {}),
                  buildVerticalButton(
                      iconName: Icons.send_outlined,
                      name: "Share",
                      onPress: () {}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
