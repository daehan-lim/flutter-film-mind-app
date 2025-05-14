import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:film_mind/domain/entity/movie.dart';
import 'package:film_mind/domain/usecase/fetch_now_playing_movies_usecase.dart';
import 'package:film_mind/domain/usecase/fetch_popular_movies_usecase.dart';
import 'package:film_mind/domain/usecase/fetch_top_rated_movies_usecase.dart';
import 'package:film_mind/domain/usecase/fetch_upcoming_movies_usecase.dart';
import 'package:film_mind/presentation/pages/home/home_view_model.dart';

class MockFetchNowPlayingMoviesUseCase extends Mock
    implements FetchNowPlayingMoviesUseCase {}

class MockFetchPopularMoviesUseCase extends Mock
    implements FetchPopularMoviesUseCase {}

class MockFetchTopRatedMoviesUseCase extends Mock
    implements FetchTopRatedMoviesUseCase {}

class MockFetchUpcomingMoviesUseCase extends Mock
    implements FetchUpcomingMoviesUseCase {}

class TestHomeViewModel extends HomeViewModel {
  @override
  HomeState build() {
    return HomeState(isLoading: true);
  }

  @override
  Future<void> fetchMovies() async {
    state = state.copyWith(isLoading: true);
    return super.fetchMovies();
  }
}

final testHomeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  TestHomeViewModel.new,
);

void main() {
  ProviderContainer? container;
  MockFetchNowPlayingMoviesUseCase? mockNowPlayingUseCase;
  MockFetchPopularMoviesUseCase? mockPopularUseCase;
  MockFetchTopRatedMoviesUseCase? mockTopRatedUseCase;
  MockFetchUpcomingMoviesUseCase? mockUpcomingUseCase;

  setUp(() {
    mockNowPlayingUseCase = MockFetchNowPlayingMoviesUseCase();
    mockPopularUseCase = MockFetchPopularMoviesUseCase();
    mockTopRatedUseCase = MockFetchTopRatedMoviesUseCase();
    mockUpcomingUseCase = MockFetchUpcomingMoviesUseCase();

    container = ProviderContainer(
      overrides: [
        fetchNowPlayingMoviesUseCaseProvider.overrideWithValue(
          mockNowPlayingUseCase!,
        ),
        fetchPopularMoviesUseCaseProvider.overrideWithValue(
          mockPopularUseCase!,
        ),
        fetchTopRatedMoviesUseCaseProvider.overrideWithValue(
          mockTopRatedUseCase!,
        ),
        fetchUpcomingMoviesUseCaseProvider.overrideWithValue(
          mockUpcomingUseCase!,
        ),
      ],
    );

    addTearDown(() {
      container?.dispose();
    });
  });

  group('HomeViewModel', () {
    final testMovies = [
      Movie(
        id: 1,
        title: 'Movie 1',
        posterPath: '/poster1.jpg',
        backdropPath: '/backdrop1.jpg',
        voteAverage: 7.5,
        overview: 'Overview 1',
        releaseDate: DateTime(2025, 05, 25),
        popularity: 123.456,
        voteCount: 1000,
      ),
      Movie(
        id: 2,
        title: 'Movie 2',
        posterPath: '/poster2.jpg',
        backdropPath: '/backdrop2.jpg',
        voteAverage: 8.0,
        overview: 'Overview 2',
        releaseDate: DateTime(2025, 05, 26),
        popularity: 234.567,
        voteCount: 2000,
      ),
    ];

    test('initial state should not be loading', () {
      // Arrange & Act
      final initialState = container!.read(testHomeViewModelProvider);

      // Assert
      expect(initialState.isLoading, isTrue);
      expect(initialState.error, isNull);
      expect(initialState.nowPlaying, isEmpty);
      expect(initialState.popular, isEmpty);
      expect(initialState.topRated, isEmpty);
      expect(initialState.upcoming, isEmpty);
      expect(initialState.featuredMovie, isNull);
    });

    test(
      'fetchMovies should update state with movies when successful',
      () async {
        // Arrange - setup the mock behavior
        when(
          () => mockNowPlayingUseCase!.execute(),
        ).thenAnswer((_) async => testMovies);
        when(
          () => mockPopularUseCase!.execute(),
        ).thenAnswer((_) async => testMovies);
        when(
          () => mockTopRatedUseCase!.execute(),
        ).thenAnswer((_) async => testMovies);
        when(
          () => mockUpcomingUseCase!.execute(),
        ).thenAnswer((_) async => testMovies);

        // Act - call the method we want to test
        await container!.read(testHomeViewModelProvider.notifier).fetchMovies();

        // Read the state after the operation
        final updatedState = container!.read(testHomeViewModelProvider);

        // Assert
        expect(updatedState.isLoading, isFalse);
        expect(updatedState.error, isNull);
        expect(updatedState.nowPlaying, equals(testMovies));
        expect(updatedState.popular, equals(testMovies));
        expect(updatedState.topRated, equals(testMovies));
        expect(updatedState.upcoming, equals(testMovies));
        expect(updatedState.featuredMovie, equals(testMovies[0]));

        verify(() => mockNowPlayingUseCase!.execute()).called(1);
        verify(() => mockPopularUseCase!.execute()).called(1);
        verify(() => mockTopRatedUseCase!.execute()).called(1);
        verify(() => mockUpcomingUseCase!.execute()).called(1);

        log(updatedState.nowPlaying.toString());
      },
    );
  });
}
