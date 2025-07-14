import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../entity/movie.dart';
import '../entity/movie_list.dart';

abstract interface class HomeRepository {
  Future<Either<Fail, MovieList>> getMovieList(int page);

  Future<Either<Fail, List<Movie>>> getFavoriteList();

  Future<Either<Fail, Movie>> favoriteMovie(String movieID);
}
