import 'package:dio/dio.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../core/network/dio.dart';
import '../model/movie_list_model.dart';
import '../model/movie_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<MovieListModel> getMovieList(int page, String token);

  Future<List<MovieModel>> getFavoriteList(String token);

  Future<MovieModel> favoriteMovie(String movieID, String token);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this.dioClient);

  final DioClient dioClient;

  @override
  Future<MovieListModel> getMovieList(int page, String token) async {
    try {
      final res = await dioClient.get(
        ApiConst.uri('movie/list', {'page': page.toString()}),
        Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (res.data['response']['code'] != 200) {
        throw ServerException(res.data['response']['message']);
      }
      return MovieListModel.fromMap(res.data['data']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ServerException(e.response!.data['response']['message']);
      }
      throw ServerException(LocaleKeys.unexpectedError);
    } catch (e) {
      throw ServerException(LocaleKeys.unexpectedError);
    }
  }

  @override
  Future<MovieModel> favoriteMovie(String movieID, String token) async {
    try {
      final res = await dioClient.post(
        ApiConst.uri('movie/favorite/$movieID'),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (res.data['response']['code'] != 200) {
        throw ServerException(res.data['response']['message']);
      }
      return MovieModel.fromMap(res.data['data']['movie']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ServerException(e.response!.data['response']['message']);
      }
      throw ServerException(LocaleKeys.unexpectedError);
    } catch (e) {
      throw ServerException(LocaleKeys.unexpectedError);
    }
  }

  @override
  Future<List<MovieModel>> getFavoriteList(String token) async {
    try {
      final res = await dioClient.get(
        ApiConst.uri('movie/favorites'),
        Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (res.data['response']['code'] != 200) {
        throw ServerException(res.data['response']['message']);
      }
      List<MovieModel> list = [];
      for (var e in res.data['data']) {
        list.add(MovieModel.fromMap(e));
      }
      return list;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ServerException(e.response!.data['response']['message']);
      }
      throw ServerException(LocaleKeys.unexpectedError);
    } catch (e) {
      throw ServerException(LocaleKeys.unexpectedError);
    }
  }
}
