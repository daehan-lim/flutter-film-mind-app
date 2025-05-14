import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/movie_detail_dto.dart';
import '../dto/movie_response_dto.dart';
import 'package:film_mind/data/data_source/base_tmdb_data_source.dart';


abstract interface class MovieDataSource {
  Future<MovieResponseDto?> fetchNowPlayingMovies();

  Future<MovieResponseDto?> fetchPopularMovies();

  Future<MovieResponseDto?> fetchTopRatedMovies();

  Future<MovieResponseDto?> fetchUpcomingMovies();

  Future<MovieDetailDto?> fetchMovieDetail(int id);
}

class MovieDataSourceImpl extends BaseTmdbDataSource
    implements MovieDataSource {
  static const moviesQueryParams = {'language': 'ko-KR', 'page': 1};

  @override
  Future<MovieResponseDto?> fetchNowPlayingMovies() async {
    try {
      final response = await dio.get(
        '/movie/now_playing',
        queryParameters: moviesQueryParams,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log('Error fetching now playing movies: $e');
      return null;
    }
  }

  @override
  Future<MovieResponseDto?> fetchPopularMovies() async {
    try {
      final response = await dio.get(
        '/movie/popular',
        queryParameters: moviesQueryParams,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log('Error fetching popular movies: $e');
      return null;
    }
  }

  @override
  Future<MovieResponseDto?> fetchTopRatedMovies() async {
    try {
      final response = await dio.get(
        '/movie/top_rated',
        queryParameters: moviesQueryParams,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log('Error fetching top rated movies: $e');
      return null;
    }
  }

  @override
  Future<MovieResponseDto?> fetchUpcomingMovies() async {
    try {
      final response = await dio.get(
        '/movie/upcoming',
        queryParameters: moviesQueryParams,
      );

      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log('Error fetching upcoming movies: $e');
      return null;
    }
  }

  @override
  Future<MovieDetailDto?> fetchMovieDetail(int id) async {
    try {
      final response = await dio.get(
        '/movie/$id',
        queryParameters: {'language': 'ko-KR'},
      );

      if (response.statusCode == 200) {
        return MovieDetailDto.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log('Error fetching movie detail: $e');
      return null;
    }
  }
}

final movieDataSourceProvider = Provider<MovieDataSource>((ref) {
  return MovieDataSourceImpl();
});
