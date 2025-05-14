import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/movie.dart';

class HomeState {
  final Movie? featuredMovie;
  final List<Movie> nowPlaying;
  final List<Movie> popular;
  final List<Movie> topRated;
  final List<Movie> upcoming;

  HomeState({
    this.featuredMovie,
    this.nowPlaying = const [],
    this.popular = const [],
    this.topRated = const [],
    this.upcoming = const [],
  });

  HomeState copyWith({
    Movie? featuredMovie,
    List<Movie>? nowPlaying,
    List<Movie>? popular,
    List<Movie>? topRated,
    List<Movie>? upcoming,
  }) {
    return HomeState(
      featuredMovie: featuredMovie ?? this.featuredMovie,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      popular: popular ?? this.popular,
      topRated: topRated ?? this.topRated,
      upcoming: upcoming ?? this.upcoming,
    );
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return loadFakeData();
  }

  HomeState loadFakeData() {
    List<Movie> generateCategory(String category, int startId) {
      return List.generate(10, (i) {
        final id = startId + i;
        return Movie(
          id: id,
          title: '$category Movie $i',
          posterUrl: 'https://picsum.photos/id/10/150/220',
        );
      });
    }

    final nowPlaying = generateCategory('NowPlaying', 100);
    final popular = generateCategory('Popular', 200);
    final topRated = generateCategory('TopRated', 300);
    final upcoming = generateCategory('Upcoming', 400);

    return HomeState(
      featuredMovie: popular[0],
      nowPlaying: nowPlaying,
      popular: popular,
      topRated: topRated,
      upcoming: upcoming,
    );
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  HomeViewModel.new,
);
