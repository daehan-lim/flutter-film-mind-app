import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/movie_response_dto.dart';
import 'package:film_mind/data/data_source/base_tmdb_data_source.dart';


abstract interface class MovieDataSource {
  Future<MovieResponseDto?> fetchNowPlayingMovies();

  Future<MovieResponseDto?> fetchPopularMovies();

  Future<MovieResponseDto?> fetchTopRatedMovies();

  Future<MovieResponseDto?> fetchUpcomingMovies();
}

class MovieDataSourceImpl extends BaseTmdbDataSource
    implements MovieDataSource {
  static const queryParameters = {'language': 'ko-KR', 'page': 1};

  @override
  Future<MovieResponseDto?> fetchNowPlayingMovies() async {
    try {
      final response = await dio.get(
        '/movie/now_playing',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error fetching now playing movies: $e');
      return null;
    }
  }

  @override
  Future<MovieResponseDto?> fetchPopularMovies() async {
    try {
      final response = await dio.get(
        '/movie/popular',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error fetching popular movies: $e');
      return null;
    }
  }

  @override
  Future<MovieResponseDto?> fetchTopRatedMovies() async {
    try {
      final response = await dio.get(
        '/movie/top_rated',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error fetching top rated movies: $e');
      return null;
    }
  }

  @override
  Future<MovieResponseDto?> fetchUpcomingMovies() async {
    try {
      final response = await dio.get(
        '/movie/upcoming',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error fetching upcoming movies: $e');
      return null;
    }
  }
}

final movieDataSourceProvider = Provider<MovieDataSource>((ref) {
  return MovieDataSourceImpl();
});
