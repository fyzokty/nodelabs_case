import 'movie.dart';
import 'pagination.dart';

class MovieList {
  final List<Movie> movies;
  final Pagination pagination;
  const MovieList({required this.movies, required this.pagination});
}
