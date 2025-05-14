import '../entity/movie.dart';

abstract interface class MovieRepository {
  Future<List<Movie>?> fetchNowPlayingMovies();

  Future<List<Movie>?> fetchPopularMovies();

  Future<List<Movie>?> fetchTopRatedMovies();

  Future<List<Movie>?> fetchUpcomingMovies();
}
