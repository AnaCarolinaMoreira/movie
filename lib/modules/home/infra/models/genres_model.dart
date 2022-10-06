// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Genres extends Equatable {
  List<Genre>? genres;

  Genres({this.genres});
  @override
  List<Object> get props => [];

  static Genres fromMap(List<Map<String, dynamic>> mapList) {
    List<Genre?> values = mapList.map((e) {
      if (e['id'] != null && e['name'] != null) return Genre.fromMap(e);
    }).toList();
    values.removeWhere((element) => element == null);
    return Genres(genres: List<Genre>.from(values));
  }
}

class Genre extends Equatable {
  int? id;
  String? name;

  Genre({this.id, this.name});

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      'id': id,
      'name': name,
    };
    return result;
  }

  static Genre fromMap(Map<String, dynamic> map) {
    Genre genre = Genre(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
    return genre;
  }
}
