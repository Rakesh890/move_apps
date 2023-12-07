import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:movie_app/presentation/widgets/movie_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: BlocConsumer<HomeBloc,HomeState>(builder:(context,state){
          debugPrint("Current State ${state.runtimeType}");
          if(state.runtimeType is  HomeMovieTrendingResponse){
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child:  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  dragStartBehavior: DragStartBehavior.start,
                  itemCount: 10,
                  itemBuilder: (context, index) => const MovieTile(),
                ));
          }else if(state.runtimeType is HomeMovieTrendingError){
            return const Center(child: Text("Error Occured "),);
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }

        }, listener: (context, state) {},
        bloc: serviceLocator<HomeBloc>(),)

    );
  }
}

