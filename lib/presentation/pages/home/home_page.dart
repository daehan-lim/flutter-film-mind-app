import 'package:film_mind/presentation/pages/home/widgets/featured_movie_card.dart';
import 'package:film_mind/presentation/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../domain/entity/movie.dart';
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
              const Text(
                '가장 인기있는',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FeaturedMovieCard(
                state.featuredMovie,
                isLoading: state.isLoading,
              ),
              const SizedBox(height: 30),
              _buildMovieSection(
                '현재 상영중',
                state.nowPlaying,
                isLoading: state.isLoading,
              ),
              const SizedBox(height: 20),
              _buildMovieSection(
                '인기순',
                state.popular,
                showRanking: true,
                isLoading: state.isLoading,
              ),
              const SizedBox(height: 20),
              _buildMovieSection(
                '평점 높은순',
                state.topRated,
                isLoading: state.isLoading,
              ),
              const SizedBox(height: 20),
              _buildMovieSection(
                '개봉예정',
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
    String sectionTitle,
    List<Movie> movies, {
    bool showRanking = false,
    bool isLoading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
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
                        isLoading ? null : movies[index],
                        index: index,
                        isLoading: isLoading,
                      )
                      : _buildMovieItem(
                        isLoading ? null : movies[index],
                        isLoading: isLoading,
                      );

              // Special left padding for the first item when ranking is shown
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 && showRanking ? 20 : 0,
                  right: showRanking && index < movies.length - 1 ? 30 : 12,
                ),
                child: movieItem,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieItem(Movie? movie, {bool isLoading = false}) {
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
            : AppCachedImage(
              imageUrl: movie!.getPosterUrl(),
              height: 180,
              width: 120,
              fit: BoxFit.cover,
            );

    return ClipRRect(borderRadius: BorderRadius.circular(12), child: image);
  }

  Widget _buildPopularItem(
    Movie? movie, {
    required int index,
    bool isLoading = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildMovieItem(movie, isLoading: isLoading),
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
