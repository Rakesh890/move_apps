import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/domain/entity/trending_movie_entity.dart';

class MovieTile extends StatelessWidget {
  final ResultsEntity movieTrendingItem;
  final Function()? onPress;
  const MovieTile(
      {Key? key, required this.movieTrendingItem, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              child: CachedNetworkImage(
                imageUrl:
                    "${ApiConfig.imageUrl}w500${movieTrendingItem.posterPath}",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ));
  }
}
