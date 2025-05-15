import '../../domain/entity/movie_detail.dart';

class MovieDetailDto {
  final int id;
  final String title;
  final String overview;
  final String tagline;
  final List<Genre> genres;
  final bool adult;
  final String backdropPath;
  final dynamic belongsToCollection;
  final int? budget;
  final String homepage;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final double? popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final bool video;
  final double? voteAverage;
  final int? voteCount;

  /// Creates a [MovieDetailDto] instance with movie details from TMDB API
  ///
  /// All parameters are required though some may be nullable based on API response
  MovieDetailDto({
    required this.id,
    required this.title,
    required this.adult,
    required this.overview,
    required this.tagline,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Factory constructor that creates a [MovieDetailDto] from a JSON map
  ///
  /// Handles null values and type conversions from TMDB API response
  factory MovieDetailDto.fromJson(Map<String, dynamic> json) {
    return MovieDetailDto(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] ?? "",
      belongsToCollection: json["belongs_to_collection"],
      budget: json["budget"],
      genres:
          json["genres"] == null
              ? []
              : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
      homepage: json["homepage"] ?? "",
      id: json["id"] ?? 0,
      imdbId: json["imdb_id"] ?? "",
      originCountry:
          json["origin_country"] == null
              ? []
              : List<String>.from(json["origin_country"]!.map((x) => x)),
      originalLanguage: json["original_language"] ?? "",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"],
      posterPath: json["poster_path"] ?? "",
      productionCompanies:
          json["production_companies"] == null
              ? []
              : List<ProductionCompany>.from(
                json["production_companies"]!.map(
                  (x) => ProductionCompany.fromJson(x),
                ),
              ),
      productionCountries:
          json["production_countries"] == null
              ? []
              : List<ProductionCountry>.from(
                json["production_countries"]!.map(
                  (x) => ProductionCountry.fromJson(x),
                ),
              ),
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      revenue: json["revenue"],
      runtime: json["runtime"],
      spokenLanguages:
          json["spoken_languages"] == null
              ? []
              : List<SpokenLanguage>.from(
                json["spoken_languages"]!.map(
                  (x) => SpokenLanguage.fromJson(x),
                ),
              ),
      status: json["status"] ?? "",
      tagline: json["tagline"] ?? "",
      title: json["title"] ?? "",
      video: json["video"] ?? false,
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  /// Converts [MovieDetailDto] to a domain entity [MovieDetail]
  ///
  /// Maps DTO fields to entity fields, transforms production company logos
  /// to full URLs, and filters out companies without logos
  MovieDetail toEntity() {
    return MovieDetail(
      id: id,
      title: title,
      tagline: tagline,
      overview: overview,
      genres: genres.map((genre) => genre.name).toList(),
      productionCompanyLogos:
          productionCompanies
              .where((company) => company.logoPath.isNotEmpty)
              .map(
                (company) =>
                    'https://image.tmdb.org/t/p/w500${company.logoPath}',
              )
              .toList(),
      popularity: popularity,
      releaseDate: releaseDate ?? DateTime.now(),
      revenue: revenue,
      runtime: runtime,
      budget: budget,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}

class Genre {
  Genre({required this.id, required this.name});

  final int id;
  final String name;

  /// Creates a [Genre] instance from a JSON map
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json["id"] ?? 0, name: json["name"] ?? "");
  }
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  /// Creates a [ProductionCountry] instance from a JSON map
  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json["id"] ?? 0,
      logoPath: json["logo_path"] ?? "",
      name: json["name"] ?? "",
      originCountry: json["origin_country"] ?? "",
    );
  }
}

class ProductionCountry {
  ProductionCountry({required this.iso31661, required this.name});

  final String iso31661;
  final String name;

  /// Creates a [ProductionCountry] instance from a JSON map
  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json["iso_3166_1"] ?? "",
      name: json["name"] ?? "",
    );
  }
}

class SpokenLanguage {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json["english_name"] ?? "",
      iso6391: json["iso_639_1"] ?? "",
      name: json["name"] ?? "",
    );
  }
}
