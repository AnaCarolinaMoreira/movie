// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'package:movie/modules/home/infra/models/belongs_to_collection_model.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';
import 'package:movie/modules/home/infra/models/production_companies_model.dart';

class Movies extends Equatable {
  List<Movie>? value;

  Movies({this.value});
  @override
  List<Object> get props => [];

  static Movies fromMap(List<Map<String, dynamic>> mapList) {
    var transactions = mapList.map((e) => Movie.fromMap(e)).toList();
    return Movies(value: transactions);
  }
}

class Movie extends Equatable {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  // List<Genres>? genres;
  Genres? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  // List<ProductionCompanies>? productionCompanies;
  ProductionCompanies? productionCompanies;
  String? releaseDate;
  int? revenue;
  int? runtime;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Movie(
      {this.adult,
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
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdropPath': backdropPath,
      'belongsToCollection': belongsToCollection,
      'budget': budget,
      'genres': genres,
      'homepage': homepage,
      'id': id,
      'imdbId': imdbId,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'productionCompanies': productionCompanies,
      'releaseDate': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  static Movie fromMap(Map<String, dynamic> map) {
    Movie movie = Movie(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      belongsToCollection: map['belongs_to_collection'] != null ? BelongsToCollection.fromMap(map['belongs_to_collection']) : null,
      budget: map['budget'] ?? 0,
      genres: map['genres'] != null ? Genres.fromMap(map['genres']) : null,
      homepage: map['homepage'],
      id: map['id'],
      imdbId: map['imdb_id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      productionCompanies: map['production_companies'] != null ? ProductionCompanies.fromMap(map['production_companies']) : null,
      releaseDate: map['release_date'],
      revenue: map['revenue'],
      runtime: map['runtime'],
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
    return movie;
  }
}
