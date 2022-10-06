// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ProductionCompanies extends Equatable {
  List<ProductionCompanie>? value;

  ProductionCompanies({this.value});
  @override
  List<Object> get props => [];

  static ProductionCompanies fromMap(List<Map<String, dynamic>> mapList) {
    List<ProductionCompanie?> values = mapList.map((e) {
      if (e['name'] != null) return ProductionCompanie.fromMap(e);
    }).toList();
    values.removeWhere((element) => element == null);
    return ProductionCompanies(value: List<ProductionCompanie>.from(values));
  }
}

class ProductionCompanie extends Equatable {
  int? id;
  String? logoPath;
  String name;
  String? originCountry;

  ProductionCompanie({this.id, this.logoPath, required this.name, this.originCountry});

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
    return result;
  }

  static ProductionCompanie fromMap(Map<String, dynamic> map) {
    ProductionCompanie productionCompanies = ProductionCompanie(
      id: map['id'] ?? 0,
      logoPath: map['logoPath'] ?? '',
      name: map['name'] ?? '',
      originCountry: map['originCountry'] ?? '',
    );
    return productionCompanies;
  }
}
