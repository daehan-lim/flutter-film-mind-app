class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String overview;
  final DateTime? releaseDate;
  final double popularity;
  final int voteCount;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
    required this.popularity,
    required this.voteCount,
  });

  /// Base URLs for TMDB images
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/';

  String getPosterUrl({String size = 'w500'}) {
    if (posterPath.isEmpty) return ''; // Return empty if no poster
    return '$_imageBaseUrl$size$posterPath';
  }

  String getBackdropUrl({String size = 'original'}) {
    if (backdropPath.isEmpty) return ''; // Return empty if no backdrop
    return '$_imageBaseUrl$size$backdropPath';
  }

  // Format release date
  String getFormattedReleaseDate() {
    if (releaseDate == null) return '';
    return '${releaseDate!.year}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return 'Movie(\n'
        'id: $id, \n'
        'title: $title, \n'
        'posterPath: ${getPosterUrl()}, \n'
        'backdropPath: ${getBackdropUrl()}, \n'
        'voteAverage: $voteAverage, \n'
        'overview: $overview, \n'
        'releaseDate: $releaseDate, \n'
        'popularity: $popularity, \n'
        'voteCount: $voteCount'
        ')';
  }
}
