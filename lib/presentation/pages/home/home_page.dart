import 'package:film_mind/core/utils/navigation_util.dart';
import 'package:film_mind/presentation/pages/home/widgets/featured_movie_card.dart';
import 'package:film_mind/presentation/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/entity/movie_category.dart';
import 'home_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                MovieCategory.featured.label,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FeaturedMovieCard(
                state.featuredMovie,
                isLoading: state.isLoading,
                categoryName: MovieCategory.featured.name,
              ),

              const SizedBox(height: 30),
              _buildMovieSection(
                MovieCategory.nowPlaying,
                state.nowPlaying,
                isLoading: state.isLoading,
              ),

              const SizedBox(height: 20),
              _buildMovieSection(
                MovieCategory.popular,
                state.popular,
                showRanking: true,
                isLoading: state.isLoading,
              ),

              const SizedBox(height: 20),
              _buildMovieSection(
                MovieCategory.topRated,
                state.topRated,
                isLoading: state.isLoading,
              ),

              const SizedBox(height: 20),
              _buildMovieSection(
                MovieCategory.upcoming,
                state.upcoming,
                isLoading: state.isLoading,
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieSection(
    MovieCategory category,
    List<Movie> movies, {
    bool showRanking = false,
    bool isLoading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: isLoading ? 6 : movies.length,
            itemBuilder: (context, index) {
              final movieItem =
                  showRanking
                      ? _buildPopularItem(
                        context: context,
                        isLoading ? null : movies[index],
                        index: index,
                        isLoading: isLoading,
                      )
                      : _buildMovieItem(
                        context: context,
                        isLoading ? null : movies[index],
                        isLoading: isLoading,
                        categoryName: category.name,
                      );

              // Special left padding for the first item when ranking is shown
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 && showRanking ? 20 : 0,
                  right: showRanking && index < movies.length - 1 ? 30 : 13,
                ),
                child: movieItem,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieItem(
    Movie? movie, {
    required BuildContext context,
    required String categoryName,
    bool isLoading = false,
  }) {
    final image =
        isLoading
            ? Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[600]!,
              child: Container(
                height: 180,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
            : GestureDetector(
              onTap: () {
                NavigationUtil.navigateToMovieDetail(
                  movie,
                  categoryName: categoryName,
                  context: context,
                );
              },
              child: Hero(
                tag: 'movie-image-${movie!.id}-$categoryName',
                child: AppCachedImage(
                  imageUrl: movie.getPosterUrl(),
                  height: 180,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            );

    return ClipRRect(borderRadius: BorderRadius.circular(12), child: image);
  }

  Widget _buildPopularItem(
    Movie? movie, {
    required BuildContext context,
    required int index,
    bool isLoading = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildMovieItem(
          movie,
          context: context,
          isLoading: isLoading,
          categoryName: MovieCategory.popular.name,
        ),
        if (!isLoading)
          Positioned(
            bottom: 0,
            left: -23,
            child: Transform.translate(
              offset: const Offset(0, 8),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.8),
                  height: 1.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
