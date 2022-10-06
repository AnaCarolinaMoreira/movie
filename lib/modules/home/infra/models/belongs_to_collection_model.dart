// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class BelongsToCollection extends Equatable {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});
  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
    };
    return result;
  }

  static BelongsToCollection fromMap(Map<String, dynamic> map) {
    BelongsToCollection belongsToCollection = BelongsToCollection(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      posterPath: map['posterPath'] ?? '',
      backdropPath: map['backdropPath'] ?? '',
    );
    return belongsToCollection;
  }
}
