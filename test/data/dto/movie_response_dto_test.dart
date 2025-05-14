import 'dart:convert';
import 'package:film_mind/data/dto/movie_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieResponseDto', () {
    test('should parse from JSON correctly', () {
      // Arrange
      final jsonString = '''
      {
        "dates": {
          "maximum": "2025-05-14",
          "minimum": "2025-04-01"
        },
        "page": 1,
        "results": [
          {
            "adult": false,
            "backdrop_path": "/backdrop.jpg",
            "genre_ids": [28, 12],
            "id": 1234,
            "original_language": "en",
            "original_title": "Test Movie",
            "overview": "Test overview",
            "popularity": 123.456,
            "poster_path": "/poster.jpg",
            "release_date": "2025-04-25",
            "title": "Test Movie KR",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 1000
          }
        ],
        "total_pages": 10,
        "total_results": 200
      }
      ''';

      // Act
      final movieResponseDto = MovieResponseDto.fromJson(json.decode(jsonString));

      // Assert
      expect(movieResponseDto.page, 1);
      expect(movieResponseDto.totalPages, 10);
      expect(movieResponseDto.totalResults, 200);
      expect(movieResponseDto.results.length, 1);

      final result = movieResponseDto.results[0];
      expect(result.id, 1234);
      expect(result.title, 'Test Movie KR');
      expect(result.posterPath, '/poster.jpg');
      expect(result.backdropPath, '/backdrop.jpg');
      expect(result.voteAverage, 7.5);
      expect(result.popularity, 123.456);
    });

  });
}