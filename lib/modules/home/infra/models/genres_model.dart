// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Genres extends Equatable {
  List<Genre>? genres;

  Genres({this.genres});
  @override
  List<Object> get props => [];

  static Genres fromMap(List<Map<String, dynamic>> mapList) {
    var genres = mapList.map((e) => Genre.fromMap(e)).toList();
    return Genres(genres: genres);
  }
}

class Genre extends Equatable {
  int id;
  String? name;
  bool value;

  Genre({required this.id, this.name, this.value = false});

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
