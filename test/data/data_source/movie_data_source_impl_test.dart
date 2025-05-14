import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:film_mind/data/data_source/movie_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

/// Testable implementation of MovieDataSourceImpl that
/// overrides the dio client
class TestMovieDataSourceImpl extends MovieDataSourceImpl {
  final Dio _mockDio;

  TestMovieDataSourceImpl(this._mockDio);

  @override
  Dio get dio => _mockDio;

  @override
  String? get bearerToken => 'test_token';
}

void main() {
  MockDio? mockDio;
  TestMovieDataSourceImpl? dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = TestMovieDataSourceImpl(mockDio!);
  });

  group('MovieDataSourceImpl', () {
    final mockResponseData = {
      "page": 1,
      "results": [
        {
          "id": 1234,
          "title": "Test Movie",
          "poster_path": "/poster.jpg",
          "backdrop_path": "/backdrop.jpg",
          "vote_average": 7.5,
          "overview": "Test overview",
          "release_date": "2024-12-25",
          "popularity": 123.456,
          "vote_count": 1000,
          "adult": false,
          "genre_ids": [28, 12],
          "original_language": "en",
          "original_title": "Test Movie",
          "video": false,
        },
      ],
      "total_pages": 10,
      "total_results": 200,
    };

    test(
      'fetchNowPlayingMovies should return MovieResponseDto when successful',
      () async {
        // Register any necessary fallbacks for mocktail
        registerFallbackValue(Options());

        // Arrange - Tell mockDio what to return when get is called
        when(
          () => mockDio!.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/movie/now_playing'),
          ),
        );

        // Act - Call the method we're testing
        final result = await dataSource!.fetchNowPlayingMovies();

        // Assert - Verify the results are correct
        expect(result, isNotNull);
        expect(result!.results.length, 1);
        expect(result.results[0].id, 1234);
        expect(result.results[0].title, 'Test Movie');

        // Assert - Verify the correct API call was made
        verify(
          () => mockDio!.get(
            '/movie/now_playing',
            queryParameters: {'language': 'ko-KR', 'page': 1},
            options: any(named: 'options'),
          ),
        ).called(1);

        log(result.toString());
        log(dataSource!.bearerToken ?? '');
        log(result.results[0].overview);
      },
    );

    test('fetchPopularMovies should return MovieResponseDto when successful', () async {
      // Arrange
      when(() => mockDio!.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      )).thenAnswer((_) async => Response(
        data: mockResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/movie/popular'),
      ));

      // Act
      final result = await dataSource!.fetchPopularMovies();

      // Assert
      expect(result, isNotNull);
      expect(result!.results.length, 1);
      expect(result.results[0].title, 'Test Movie');

      verify(() => mockDio!.get(
        '/movie/popular',
        queryParameters: {'language': 'ko-KR', 'page': 1},
        options: any(named: 'options'),
      )).called(1);
    });

    test('fetchNowPlayingMovies should return null when request fails', () async {
      // Arrange
      when(() => mockDio!.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/movie/now_playing'),
        error: 'Network error',
      ));

      // Act
      final result = await dataSource!.fetchNowPlayingMovies();

      // Assert
      expect(result, isNull);
    });

  });
}
