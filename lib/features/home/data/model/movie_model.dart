import 'dart:convert';

import '../../domain/entity/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.plot,
    required super.poster,
    required super.released,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'Title': title, 'Plot': plot, 'Poster': poster, 'Released': released};
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: (map["id"] ?? '') as String,
      title: (map["Title"] ?? '') as String,
      plot: (map["Plot"] ?? '') as String,
      poster: (map["Poster"] ?? '') as String,
      released: (map["Released"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
