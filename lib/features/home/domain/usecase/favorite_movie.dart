import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/movie.dart';
import '../repository/home_repository.dart';

class FavoriteMovie implements UseCase<Movie, FavoriteMovieParams> {
  FavoriteMovie(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<Either<Fail, Movie>> call(FavoriteMovieParams params) async {
    return await homeRepository.favoriteMovie(params.movieID);
  }
}

class FavoriteMovieParams {
  const FavoriteMovieParams(this.movieID);

  final String movieID;
}
