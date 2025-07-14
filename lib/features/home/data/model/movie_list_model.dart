import 'dart:convert';

import '../../domain/entity/movie_list.dart';
import 'movie_model.dart';
import 'pagination_model.dart';

class MovieListModel extends MovieList {
  MovieListModel({required super.movies, required super.pagination});

  factory MovieListModel.fromMap(Map<String, dynamic> map) {
    return MovieListModel(
      movies: List<MovieModel>.from(
        ((map['movies'] ?? const <MovieModel>[]) as List).map<MovieModel>((x) {
          return MovieModel.fromMap((x ?? Map<String, dynamic>.from({})) as Map<String, dynamic>);
        }),
      ),
      pagination: PaginationModel.fromMap((map["pagination"] ?? Map<String, dynamic>.from({})) as Map<String, dynamic>),
    );
  }

  factory MovieListModel.fromJson(String source) => MovieListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
