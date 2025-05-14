import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/navigation_util.dart';
import '../../../../domain/entity/movie.dart';
import '../../../widgets/app_cached_image.dart';

class FeaturedMovieCard extends StatelessWidget {
  final Movie? movie;
  final bool isLoading;
  final String categoryName;

  const FeaturedMovieCard(
    this.movie, {
    super.key,
    required this.categoryName,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          NavigationUtil.navigateToMovieDetail(
            movie!,
            context: context,
            categoryName: categoryName,
          );
        }
      },
      child: Padding(
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
                  : Hero(
                    tag: 'movie-image-${movie!.id}-$categoryName',
                    child: AppCachedImage(
                      imageUrl: movie!.getPosterUrl(size: 'original'),
                      height: 450,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
        ),
      ),
    );
  }
}
