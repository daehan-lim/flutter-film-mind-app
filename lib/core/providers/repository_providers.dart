import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_source/movie_data_source.dart';
import '../../data/repository/movie_repository_impl.dart';
import '../../domain/repository/movie_repository.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dataSource = ref.watch(movieDataSourceProvider);
  return MovieRepositoryImpl(dataSource);
});