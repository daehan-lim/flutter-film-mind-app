import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/usecase/fetch_now_playing_movies_usecase.dart';
import '../../../domain/usecase/fetch_popular_movies_usecase.dart';
import '../../../domain/usecase/fetch_top_rated_movies_usecase.dart';
import '../../../domain/usecase/fetch_upcoming_movies_usecase.dart';

class HomeState {
  final Movie? featuredMovie;
  final List<Movie> nowPlaying;
  final List<Movie> popular;
  final List<Movie> topRated;
  final List<Movie> upcoming;
  final bool isLoading;
  final String? error;

  HomeState({
    this.featuredMovie,
    this.nowPlaying = const [],
    this.popular = const [],
    this.topRated = const [],
    this.upcoming = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    Movie? featuredMovie,
    List<Movie>? nowPlaying,
    List<Movie>? popular,
    List<Movie>? topRated,
    List<Movie>? upcoming,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      featuredMovie: featuredMovie ?? this.featuredMovie,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      popular: popular ?? this.popular,
      topRated: topRated ?? this.topRated,
      upcoming: upcoming ?? this.upcoming,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    fetchMovies();
    return HomeState(isLoading: true);
  }

  Future<void> fetchMovies() async {
    try {
      // Fetch all movie categories in parallel
      final results = await Future.wait([
        ref.read(fetchNowPlayingMoviesUseCaseProvider).execute(),
        ref.read(fetchPopularMoviesUseCaseProvider).execute(),
        ref.read(fetchTopRatedMoviesUseCaseProvider).execute(),
        ref.read(fetchUpcomingMoviesUseCaseProvider).execute(),
      ]);

      final List<Movie> nowPlaying = results[0];
      final List<Movie> popular = results[1];
      final List<Movie> topRated = results[2];
      final List<Movie> upcoming = results[3];

      // Set the most popular movie as featured if available
      final Movie? featuredMovie = popular.isNotEmpty ? popular[0] : null;

      state = state.copyWith(
        isLoading: false,
        nowPlaying: nowPlaying,
        popular: popular,
        topRated: topRated,
        upcoming: upcoming,
        featuredMovie: featuredMovie,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load movies: $e',
      );
    }
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  HomeViewModel.new,
);
