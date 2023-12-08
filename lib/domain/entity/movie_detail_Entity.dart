import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollectionEntity? belongsToCollection;
  final int? budget;
  final List<GenresEntity>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompaniesEntity>? productionCompanies;
  final List<ProductionCountriesEntity>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguagesEntity>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const MovieDetailEntity({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });


  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    belongsToCollection,
    budget,
    genres,
    homepage,
    id,
    imdbId,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    productionCountries,
    releaseDate,
    revenue,
    runtime,
    spokenLanguages,
    status,
    tagline,
    title,
    video,
    voteAverage,
    voteCount,
  ];
}

class BelongsToCollectionEntity extends Equatable {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  const BelongsToCollectionEntity({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    posterPath,
    backdropPath,
  ];
}

class GenresEntity extends Equatable {
  final int? id;
  final String? name;

  const GenresEntity({
    this.id,
    this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
  ];
}

class ProductionCompaniesEntity extends Equatable {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  const ProductionCompaniesEntity({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    logoPath,
    name,
    originCountry,
  ];


}

class ProductionCountriesEntity extends Equatable {
  final String? iso31661;
  final String? name;

  const ProductionCountriesEntity({
    this.iso31661,
    this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    iso31661,
    name,
  ];


}

class SpokenLanguagesEntity extends Equatable{
  final String? englishName;
  final String? iso6391;
  final String? name;

  const SpokenLanguagesEntity({
    this.englishName,
    this.iso6391,
    this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [englishName,
    iso6391,
    name,];


}