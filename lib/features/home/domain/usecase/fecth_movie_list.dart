import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/movie_list.dart';
import '../repository/home_repository.dart';

class FecthMovieList implements UseCase<MovieList, FetchMovieListParams> {
  FecthMovieList(this.homeRepository);
  final HomeRepository homeRepository;

  @override
  Future<Either<Fail, MovieList>> call(FetchMovieListParams params) async {
    return await homeRepository.getMovieList(params.page);
  }
}

class FetchMovieListParams {
  const FetchMovieListParams(this.page);
  final int page;
}
