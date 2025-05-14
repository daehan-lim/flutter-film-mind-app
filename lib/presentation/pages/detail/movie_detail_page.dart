import 'package:film_mind/core/extensions/date_extensions.dart';
import 'package:film_mind/presentation/pages/detail/widgets/companies_list.dart';
import 'package:film_mind/presentation/pages/detail/widgets/genre_chips.dart';
import 'package:film_mind/presentation/pages/detail/widgets/movie_stats.dart';
import 'package:film_mind/presentation/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/constants/app_styles.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/entity/movie_detail.dart';
import '../../widgets/app_cached_image.dart';
import 'movie_detail_view_model.dart';

class MovieDetailPage extends ConsumerWidget {
  final Movie movie;
  final String categoryName;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(movieDetailViewModelProvider(movie));
    final detail = state.movieDetail;

    return Scaffold(
      appBar: AppBar(titleSpacing: 0, actions: [_buildPopupMenu()]),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Hero(
              tag: 'movie-image-${movie.id}-$categoryName',
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

  PopupMenuButton<int> _buildPopupMenu() {
    return PopupMenuButton<int>(
      color: const Color(0xFF202020),
      // dark background like in image
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      offset: const Offset(0, 50),
      padding: EdgeInsets.zero,
      itemBuilder:
          (context) => [
            _buildPopupItem(
              context,
              value: 0,
              text: '구글 검색',
              iconAsset: 'assets/icons/google_icon.svg',
              dimension: 19,
            ),
            const PopupMenuDivider(),
            _buildPopupItem(
              context,
              value: 1,
              text: '네이버 검색',
              iconAsset: 'assets/icons/naver_icon.svg',
              dimension: 16,
            ),
          ],
      onSelected: (value) async {
        final query = Uri.encodeComponent('${movie.title} 영화');
        final url = value == 0
            ? 'https://www.google.com/search?q=$query'
            : 'https://search.naver.com/search.naver?query=$query';
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.inAppBrowserView,
        );
      },
    );
  }

  PopupMenuItem<int> _buildPopupItem(
    BuildContext context, {
    required int value,
    required String text,
    required String iconAsset,
    required double dimension,
  }) {
    return PopupMenuItem<int>(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(width: 1),
          SvgPicture.asset(
            iconAsset,
            width: dimension,
            height: dimension,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            placeholderBuilder:
                (_) => SizedBox(width: dimension, height: dimension),
          ),
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
