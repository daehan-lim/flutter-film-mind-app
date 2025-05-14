import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/repository_providers.dart';
import '../entity/movie_detail.dart';
import '../repository/movie_repository.dart';

class FetchMovieDetailUseCase {
  final MovieRepository _repository;

  FetchMovieDetailUseCase(this._repository);

  Future<MovieDetail?> execute(int id) async {
    return await _repository.fetchMovieDetail(id);
  }
}

final fetchMovieDetailUseCaseProvider = Provider<FetchMovieDetailUseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchMovieDetailUseCase(repository);
});