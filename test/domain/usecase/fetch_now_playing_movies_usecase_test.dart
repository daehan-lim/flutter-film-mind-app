import 'dart:developer';

import 'package:film_mind/domain/entity/movie.dart';
import 'package:film_mind/domain/repository/movie_repository.dart';
import 'package:film_mind/domain/usecase/fetch_now_playing_movies_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  MockMovieRepository? mockRepository;
  FetchNowPlayingMoviesUseCase? useCase;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = FetchNowPlayingMoviesUseCase(mockRepository!);
  });

  group('FetchNowPlayingMoviesUseCase', () {
    final testMovies = [
      Movie(
        id: 1234,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        voteAverage: 7.5,
        overview: 'Test overview',
        releaseDate: DateTime(2025, 05, 25),
        popularity: 123.456,
        voteCount: 1000,
      ),
    ];

    test('execute should return list of movies from repository', () async {
      // Arrange
      when(() => mockRepository!.fetchNowPlayingMovies())
          .thenAnswer((_) async => testMovies);

      // Act
      final result = await useCase!.execute();

      // Assert
      expect(result, equals(testMovies));
      verify(() => mockRepository!.fetchNowPlayingMovies()).called(1);

      log(result.toString());
    });

    test('execute should return empty list when repository returns null', () async {
      // Arrange
      when(() => mockRepository!.fetchNowPlayingMovies())
          .thenAnswer((_) async => null);

      // Act
      final result = await useCase!.execute();

      // Assert
      expect(result, isEmpty);
    });
  });
}