import 'package:flutter/material.dart';

class MyMoviesPage extends StatelessWidget {
  const MyMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Movies Of user",
      style: TextStyle(color: Colors.white,fontSize: 20),)),
    );
  }
}
