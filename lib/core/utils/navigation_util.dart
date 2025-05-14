import 'package:film_mind/presentation/pages/detail/movie_detail_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/movie.dart';

abstract class NavigationUtil {
  static void navigateToMovieDetail(
    Movie movie, {
    required BuildContext context,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movie)),
    );
  }
}
