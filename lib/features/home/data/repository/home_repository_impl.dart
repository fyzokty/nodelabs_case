import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/fail.dart';
import '../../../auth/data/datasource/auth_local_data_source.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_list.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this.authLocalDataSource, required this.homeRemoteDataSource});

  final HomeRemoteDataSource homeRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  Future<String?> _getToken() async {
    return await authLocalDataSource.readToken();
  }

  @override
  Future<Either<Fail, Movie>> favoriteMovie(String movieID) async {
    try {
      final token = await _getToken();
      if (token == null) {
        return left(Fail('TOKEN_NULL'));
      }
      final movie = await homeRemoteDataSource.favoriteMovie(movieID, token);
      return right(movie);
    } on ServerException catch (e) {
      return left(Fail(e.message));
    }
  }

  @override
  Future<Either<Fail, List<Movie>>> getFavoriteList() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return left(Fail('TOKEN_NULL'));
      }
      final favoriteList = await homeRemoteDataSource.getFavoriteList(token);
      return right(favoriteList);
    } on ServerException catch (e) {
      return left(Fail(e.message));
    }
  }

  @override
  Future<Either<Fail, MovieList>> getMovieList(int page) async {
    try {
      final token = await _getToken();
      if (token == null) {
        return left(Fail('TOKEN_NULL'));
      }
      final movieList = await homeRemoteDataSource.getMovieList(page, token);
      return right(movieList);
    } on ServerException catch (e) {
      return left(Fail(e.message));
    }
  }
}
