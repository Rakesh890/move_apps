import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          //CachedNetworkImage(imageUrl: ""),
          Text("Number",
            style: TextStyle(color:Colors.white,fontSize: 14.0,fontWeight: FontWeight.w500),
          )
        ],
      ));
  }
}
