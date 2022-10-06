// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Casts extends Equatable {
  int? id;
  List<Cast>? value;

  Casts({this.id, this.value});
  @override
  List<Object> get props => [];

  static Casts fromMap(List<Map<String, dynamic>> mapList) {
    List<Cast?> values = mapList.map((e) {
      if (e['name'] != null && e['known_for_department'] != null) return Cast.fromMap(e);
    }).toList();
    values.removeWhere((element) => element == null);
    return Casts(value: List<Cast>.from(values));
  }
}

class Cast extends Equatable {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  Cast(
      {this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order});

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'gender': gender,
      'id': id,
      'knownForDepartment': knownForDepartment,
      'name': name,
      'originalName': originalName,
      'popularity': popularity,
      'profilePath': profilePath,
      'castId': castId,
      'character': character,
      'creditId': creditId,
      'order': order,
    };
  }

  static Cast fromMap(Map<String, dynamic> json) {
    Cast cast = Cast(
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: json['popularity'],
      profilePath: json['profile_path'],
      castId: json['cast_id'],
      character: json['character'],
      creditId: json['credit_id'],
      order: json['order'],
    );
    return cast;
  }
}
