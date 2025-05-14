import 'package:film_mind/presentation/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                'Most Popular',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildFeaturedMovie(state.featuredMovie),
              const SizedBox(height: 30),
              _buildMovieSection('Now Playing', state.nowPlaying),
              const SizedBox(height: 20),
              _buildMovieSection('Popular', state.popular, showRanking: true),
              const SizedBox(height: 20),
              _buildMovieSection('Top Rated', state.topRated),
              const SizedBox(height: 20),
              _buildMovieSection('Upcoming', state.upcoming),
              const SizedBox(height: 20),
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
          imageUrl: movie.posterUrl,
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
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              if (!showRanking) {
                return _buildMovieItem(movies[index]);
              }
              return _buildPopularItem(movies[index], index: index);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieItem(Movie movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AppCachedImage(
        imageUrl: movie.posterUrl,
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
          bottom: 8,
          left: 8,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
