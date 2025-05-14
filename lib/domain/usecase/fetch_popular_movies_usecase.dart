import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/repository_providers.dart';
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchPopularMoviesUseCase {
  final MovieRepository _repository;

  FetchPopularMoviesUseCase(this._repository);

  Future<List<Movie>> execute() async {
    return await _repository.fetchPopularMovies() ?? [];
  }
}

final fetchPopularMoviesUseCaseProvider = Provider<FetchPopularMoviesUseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchPopularMoviesUseCase(repository);
});