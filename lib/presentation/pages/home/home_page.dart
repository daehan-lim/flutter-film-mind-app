import 'package:film_mind/presentation/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entity/movie.dart';
import 'home_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(homeViewModelProvider.notifier).fetchMovies();
    // });
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
              _buildFeaturedMovie(state.featuredMovie),
              const SizedBox(height: 30),
              _buildMovieSection('현재 상영중', state.nowPlaying),
              const SizedBox(height: 20),
              _buildMovieSection('인기순', state.popular, showRanking: true),
              const SizedBox(height: 20),
              _buildMovieSection('평점 높은순', state.topRated),
              const SizedBox(height: 20),
              _buildMovieSection('개봉예정', state.upcoming),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedMovie(Movie? movie) {
    if (movie == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AppCachedImage(
          imageUrl: movie.getPosterUrl(size: 'original'),
          height: 450,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMovieSection(
    String sectionTitle,
    List<Movie> movies, {
    bool showRanking = false,
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
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movieItem =
                  showRanking
                      ? _buildPopularItem(movies[index], index: index)
                      : _buildMovieItem(movies[index]);

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

  Widget _buildMovieItem(Movie movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AppCachedImage(
        imageUrl: movie.getPosterUrl(),
        height: 180,
        width: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPopularItem(Movie movie, {required int index}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildMovieItem(movie),
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
                height: 1.0, // prevents extra line spacing
              ),
            ),
          ),
        ),
      ],
    );
  }
}
