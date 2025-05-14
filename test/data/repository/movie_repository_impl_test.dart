import 'package:film_mind/data/data_source/movie_data_source.dart';
import 'package:film_mind/data/dto/movie_response_dto.dart';
import 'package:film_mind/data/repository/movie_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieDataSource extends Mock implements MovieDataSource {}

void main() {
  MovieRepositoryImpl? repository;
  MockMovieDataSource? mockDataSource;

  setUp(() {
    mockDataSource = MockMovieDataSource();
    repository = MovieRepositoryImpl(mockDataSource!);
  });

  group('MovieRepositoryImpl', () {
    final testDateTime = DateTime(2025, 05, 25);

    final testMovieResponseDto = MovieResponseDto(
      page: 1,
      results: [
        Result(
          adult: false,
          backdropPath: '/backdrop.jpg',
          genreIds: [28, 12],
          id: 1234,
          originalLanguage: 'en',
          originalTitle: 'Test Movie',
          overview: 'Test overview',
          popularity: 123.456,
          posterPath: '/poster.jpg',
          releaseDate: testDateTime,
          title: 'Test Movie',
          video: false,
          voteAverage: 7.5,
          voteCount: 1000,
        ),
      ],
      totalPages: 10,
      totalResults: 200,
      dates: null,
    );

    test(
      'fetchNowPlayingMovies should return list of Movies when successful',
      () async {
        // Arrange
        when(
          () => mockDataSource!.fetchNowPlayingMovies(),
        ).thenAnswer((_) async => testMovieResponseDto);

        // Act
        final result = await repository!.fetchNowPlayingMovies();

        // Assert
        expect(result, isNotNull);
        expect(result!.length, 1);

        final movie = result[0];
        expect(movie.id, 1234);
        expect(movie.title, 'Test Movie');
        expect(movie.posterPath, '/poster.jpg');
        expect(movie.releaseDate, testDateTime);

        verify(() => mockDataSource!.fetchNowPlayingMovies()).called(1);

        print(result[0].overview);
      },
    );

    test(
      'fetchPopularMovies should return list of Movies when successful',
      () async {
        // Arrange
        when(
          () => mockDataSource!.fetchPopularMovies(),
        ).thenAnswer((_) async => testMovieResponseDto);

        // Act
        final result = await repository!.fetchPopularMovies();

        // Assert
        expect(result, isNotNull);
        expect(result!.length, 1);

        verify(() => mockDataSource!.fetchPopularMovies()).called(1);
      },
    );

    test(
      'fetchNowPlayingMovies should return null when data source returns null',
      () async {
        // Arrange
        when(
          () => mockDataSource!.fetchNowPlayingMovies(),
        ).thenAnswer((_) async => null);

        // Act
        final result = await repository!.fetchNowPlayingMovies();

        // Assert
        expect(result, isNull);
      },
    );
  });
}
