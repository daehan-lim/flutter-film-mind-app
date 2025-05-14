import '../../domain/entity/movie.dart';

class MovieResponseDto {
  MovieResponseDto({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates? dates;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) {
    return MovieResponseDto(
      dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
      page: json["page"] ?? 0,
      results:
          json["results"] == null
              ? []
              : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x)),
              ),
      totalPages: json["total_pages"] ?? 0,
      totalResults: json["total_results"] ?? 0,
    );
  }

  List<Movie> toEntityList() {
    return results.map((result) => result.toEntity()).toList();
  }

  @override
  String toString() {
    return 'MovieResponseDto(page: $page, totalPages: $totalPages, totalResults: $totalResults, resultsCount: ${results.length}, dates: $dates)';
  }
}

class Dates {
  Dates({required this.maximum, required this.minimum});

  final DateTime? maximum;
  final DateTime? minimum;

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: DateTime.tryParse(json["maximum"] ?? ""),
      minimum: DateTime.tryParse(json["minimum"] ?? ""),
    );
  }
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] ?? "",
      genreIds:
          json["genre_ids"] == null
              ? []
              : List<int>.from(json["genre_ids"]!.map((x) => x)),
      id: json["id"] ?? 0,
      originalLanguage: json["original_language"] ?? "",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"] ?? 0.0,
      posterPath: json["poster_path"] ?? "",
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      title: json["title"] ?? "",
      video: json["video"] ?? false,
      voteAverage: json["vote_average"] ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      overview: overview,
      releaseDate: releaseDate,
      popularity: popularity,
      voteCount: voteCount,
    );
  }
}
