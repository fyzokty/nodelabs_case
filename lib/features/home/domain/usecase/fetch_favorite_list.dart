import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/movie.dart';
import '../repository/home_repository.dart';

class FetchFavoriteList implements UseCase<List<Movie>, NoParams> {
  const FetchFavoriteList(this.homeRepository);
  final HomeRepository homeRepository;

  @override
  Future<Either<Fail, List<Movie>>> call(NoParams params) async {
    return await homeRepository.getFavoriteList();
  }
}
