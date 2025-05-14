import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/repository_providers.dart';
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchTopRatedMoviesUseCase {
  final MovieRepository _repository;

  FetchTopRatedMoviesUseCase(this._repository);

  Future<List<Movie>> execute() async {
    return await _repository.fetchTopRatedMovies() ?? [];
  }
}

final fetchTopRatedMoviesUseCaseProvider = Provider<FetchTopRatedMoviesUseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchTopRatedMoviesUseCase(repository);
});