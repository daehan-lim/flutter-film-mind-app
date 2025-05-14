import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../domain/entity/movie.dart';
import '../../../widgets/app_cached_image.dart';

class FeaturedMovieCard extends StatelessWidget {
  final Movie? movie;
  final bool isLoading;

  const FeaturedMovieCard(this.movie, {super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child:
            isLoading
                ? Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 450,
                    width: double.infinity,
                    color: Colors.grey[850],
                  ),
                )
                : AppCachedImage(
                  imageUrl: movie!.getPosterUrl(size: 'original'),
                  height: 450,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
      ),
    );
  }
}
