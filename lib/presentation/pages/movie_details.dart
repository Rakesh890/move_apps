import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/widgets/button_widget.dart';
import 'package:movie_app/utils/extensions/sized_box_extension.dart';
import 'package:movie_app/utils/extensions/time_conversion.dart';
import 'package:video_player/video_player.dart';
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
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black.withOpacity(0.7),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const CircularProgressIndicator();
                  }
                  return mainBody(state);
                },
                bloc: serviceLocator<MovieDetailsBloc>()
                  ..add(FetchMovieDetailsFromApiEvent(
                      apiUrl:
                          "${ApiConfig.movieDetails}/${widget.movieId}?${ApiConfig.apiKey}")),
              ),
              BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, state) {
                  if (state is LoadinRecommendedMovie) {
                    return const CircularProgressIndicator();
                  } else if (state is RecommendedMoviesResponse) {
                    debugPrint(state.recommendedMoviesList.length.toString());
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: state.recommendedMoviesList
                          .length, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        return GridTile(
                          child: Container(
                            color: Colors.blue,
                            child: Center(
                              child: Text('Item $index'),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("Happing");
                  }
                },
                bloc: serviceLocator<MovieDetailsBloc>()
                  ..add(FetchRecommendedMovieEvent(
                      apiUrl:
                          "${ApiConfig.recommedMoviesUrl}/${widget.movieId}/recommendations?${ApiConfig.apiKey}")),
              ),
            ],
          ),
        ));
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
  Widget mainBody(state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
            imageUrl:
                "${ApiConfig.imageUrl}/w500/${state.movieDetailEntity.posterPath}",
            height: 500,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              state.movieDetailEntity.title.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700),
            ),
            5.h,
            RichText(
              text: TextSpan(
                text:
                    "${state.movieDetailEntity.popularity!.floorToDouble() / 10} % match"
                        .toString(),
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(
                    text: ' ${state.movieDetailEntity.releaseDate} ',
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
            ButtonWidget(
              onPress: () {},
              buttonName: "Play",
              iconName: Icons.play_arrow_rounded,
              buttonBgColors: Colors.white,
              textColor: Colors.black,
              iconColor: Colors.black,
            ),
            10.h,
            ButtonWidget(
              onPress: () {},
              buttonName: "Download",
              iconName: Icons.file_download,
              buttonBgColors: Colors.grey.shade900,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            10.h,
            Text(
              state.movieDetailEntity.overview.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildVerticalButton(
                    iconName: Icons.add, name: "My List", onPress: () {}),
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
        10.h,
      ],
    );
  }
}
