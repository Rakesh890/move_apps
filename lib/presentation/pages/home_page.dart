import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/entity/movie.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/blocs/home_bloc.dart';
import 'package:movie_app/presentation/widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: mainBody(),
    );
  }

  Widget mainBody() {
      return BlocBuilder<HomeBloc,HomeState>(builder: (context, state) {
        if(state is HLoadingMovie){
          return const Center(child: CupertinoActivityIndicator(),);
        }
        else if(state is HMovieResponse){
          debugPrint('s : ${state.popularMovie!.length}');
          debugPrint('s : ${state.trendingMovie!.length}');
          return ListView(
            children: <Widget>[

              CarosuleCard(state.topRatedMovies),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Top Rated Movies",
                    style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:  Row(
                        children: List.generate(state.topRatedMovies.length, (index) => MovieCard(state.topRatedMovies[index])).toList(),
                      )),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  Row(
                      children: List.generate(state.popularMovie.length, (index) => MovieCard(state.popularMovie[index])).toList(),
                    ),

                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  Row(
                      children: List.generate(state.trendingMovie!.length, (index) => MovieCard(state.trendingMovie[index])).toList(),
                    ),

                  ),
                ],
              )


            ],
          );
        } else if(state is HMovieError){
          return Center(child: Text("Something went wrong $state"),);
        }

        return const SizedBox.shrink();
      },);
  }

  Widget CarosuleCard(List<ResultsEntity> topRatedMovies) {
    return  Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
       Positioned.fill(child:  Container(
         constraints: const BoxConstraints.expand(),
         decoration:  BoxDecoration(
           image: DecorationImage(
             image: NetworkImage(
               "https://image.tmdb.org/t/p/w500/${topRatedMovies[pageIndex].backdropPath}",
             ),
             fit: BoxFit.cover,
           ),
         ),
         child: BackdropFilter(
           filter: ImageFilter.blur(
             sigmaX: 20,
             sigmaY: 20,
           ),
           child: Container(
             color: Colors.black.withOpacity(0.1),
           ),
         ),),),

        PageView.builder(
          controller: PageController(initialPage: pageIndex),
          onPageChanged: (val) => setState(() {
            pageIndex = val;
          }),
          itemCount: topRatedMovies.length,
          itemBuilder: (context, index) =>
              Container(
                margin: EdgeInsets.only(left: 50,right: 50,top:50,bottom: 75),
                child: Image.network("https://image.tmdb.org/t/p/w500/${topRatedMovies[index].backdropPath}",
                fit: BoxFit.fitHeight),
              ),)
      ],
    );


  }
}
