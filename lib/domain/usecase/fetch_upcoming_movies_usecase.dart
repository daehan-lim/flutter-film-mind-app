import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/repository_providers.dart';
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchUpcomingMoviesUseCase {
  final MovieRepository _repository;

  FetchUpcomingMoviesUseCase(this._repository);

  Future<List<Movie>> execute() async {
    return await _repository.fetchUpcomingMovies() ?? [];
  }
}

final fetchUpcomingMoviesUseCaseProvider = Provider<FetchUpcomingMoviesUseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchUpcomingMoviesUseCase(repository);
});