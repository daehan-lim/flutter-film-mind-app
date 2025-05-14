import 'package:film_mind/core/extensions/date_extensions.dart';
import 'package:film_mind/presentation/pages/detail/widgets/companies_list.dart';
import 'package:film_mind/presentation/pages/detail/widgets/genre_chips.dart';
import 'package:film_mind/presentation/pages/detail/widgets/movie_stats.dart';
import 'package:film_mind/presentation/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/constants/app_styles.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/entity/movie_detail.dart';
import '../../widgets/app_cached_image.dart';
import 'movie_detail_view_model.dart';

class MovieDetailPage extends ConsumerWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(movieDetailViewModelProvider(movie));
    final detail = state.movieDetail;

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Hero(
              tag: 'movie-image-${movie.id}',
              child: AppCachedImage(
                imageUrl: movie.getPosterUrl(),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(child: _buildContentLayout(state, detail)),
        ],
      ),
    );
  }

  Widget _buildContentLayout(DetailState state, MovieDetail? detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Title and Release Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text(
                movie.releaseDate?.formatYMD() ?? '',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),

          // Tagline (only shown if not empty)
          if (state.isLoading) ...[
            const SizedBox(height: 10),
            CustomShimmer(width: 200, height: 20),
          ] else if (detail!.tagline.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(detail.tagline, style: const TextStyle(fontSize: 16)),
          ],

          // Runtime
          const SizedBox(height: 8),
          state.isLoading
              ? CustomShimmer(width: 60, height: 18)
              : Text(detail!.runtime, style: const TextStyle(fontSize: 16)),

          // Genre chips
          const SizedBox(height: 5),
          Divider(),
          const SizedBox(height: 3),
          GenreChips(isLoading: state.isLoading, detail: detail),

          // Overview
          if (movie.overview.isNotEmpty) ...[
            const SizedBox(height: 3),
            Divider(),
            const SizedBox(height: 10),
            const Text('시놉시스', style: AppStyles.detailSectionText),
            const SizedBox(height: 7),
            Text(
              movie.overview,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],

          // Stats in horizontal scrollable list
          const SizedBox(height: 25),
          const Text('흥행정보', style: AppStyles.detailSectionText),
          const SizedBox(height: 10),
          MovieStats(isLoading: state.isLoading, detail: detail),

          // Production Companies
          if ((state.isLoading) ||
              (detail != null && detail.productionCompanyLogos.isNotEmpty)) ...[
            const SizedBox(height: 25),
            const Text('제작사', style: AppStyles.detailSectionText),
            const SizedBox(height: 10),
            CompaniesList(isLoading: state.isLoading, detail: detail),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
