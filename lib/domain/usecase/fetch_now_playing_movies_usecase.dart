import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/repository_providers.dart';
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchNowPlayingMoviesUseCase {
  final MovieRepository _repository;

  FetchNowPlayingMoviesUseCase(this._repository);

  Future<List<Movie>> execute() async {
    return await _repository.fetchNowPlayingMovies() ?? [];
  }
}

final fetchNowPlayingMoviesUseCaseProvider = Provider<FetchNowPlayingMoviesUseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchNowPlayingMoviesUseCase(repository);
});