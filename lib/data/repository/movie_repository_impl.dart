import '../../domain/entity/movie.dart';
import '../../domain/repository/movie_repository.dart';
import '../data_source/movie_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource _dataSource;

  MovieRepositoryImpl(this._dataSource);

  @override
  Future<List<Movie>?> fetchNowPlayingMovies() async {
    final responseDto = await _dataSource.fetchNowPlayingMovies();
    return responseDto?.results.map((result) => result.toEntity()).toList();
  }

  @override
  Future<List<Movie>?> fetchPopularMovies() async {
    final responseDto = await _dataSource.fetchPopularMovies();
    return responseDto?.results.map((result) => result.toEntity()).toList();
  }

  @override
  Future<List<Movie>?> fetchTopRatedMovies() async {
    final responseDto = await _dataSource.fetchTopRatedMovies();
    return responseDto?.results.map((result) => result.toEntity()).toList();
  }

  @override
  Future<List<Movie>?> fetchUpcomingMovies() async {
    final responseDto = await _dataSource.fetchUpcomingMovies();
    return responseDto?.results.map((result) => result.toEntity()).toList();
  }
}
