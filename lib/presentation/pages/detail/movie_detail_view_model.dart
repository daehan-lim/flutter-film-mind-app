import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/movie.dart';
import '../../../domain/entity/movie_detail.dart';
import '../../../domain/usecase/fetch_movie_detail_usecase.dart';

class DetailState {
  final MovieDetail? movieDetail;
  final bool isLoading;
  final String? error;

  DetailState({this.movieDetail, this.isLoading = false, this.error});

  DetailState copyWith({
    Movie? initialMovie,
    MovieDetail? movieDetail,
    bool? isLoading,
    String? error,
  }) {
    return DetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class MovieDetailViewModel
    extends AutoDisposeFamilyNotifier<DetailState, Movie> {
  @override
  DetailState build(Movie arg) {
    fetchMovieDetail();
    return DetailState(isLoading: true);
  }

  Future<void> fetchMovieDetail() async {
    try {
      final movieDetail = await ref
          .read(fetchMovieDetailUseCaseProvider)
          .execute(arg.id);

      if (movieDetail != null) {
        state = state.copyWith(isLoading: false, movieDetail: movieDetail);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to load movie details',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error loading movie details: $e',
      );
    }
  }
}

final movieDetailViewModelProvider = NotifierProvider.autoDispose
    .family<MovieDetailViewModel, DetailState, Movie>(MovieDetailViewModel.new);
