import 'package:dio/dio.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../core/network/dio.dart';
import '../model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({required String fullname, required String email, required String password});

  Future<UserModel> getUser({required String token});

  Future<UserModel> uploadPhoto({required String imagePath, required String token});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dioClient);

  final DioClient dioClient;

  @override
  Future<UserModel> login({required String email, required String password}) async {
    final map = {'email': email, 'password': password};
    try {
      final res = await dioClient.post(ApiConst.login, data: map);
      if (res.data['response']['code'] != 200) {
        throw ServerException(res.data['response']['message']);
      }
      return UserModel.fromMap(res.data['data']);
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
  Future<UserModel> register({required String fullname, required String email, required String password}) async {
    final map = {'name': fullname, 'email': email, 'password': password};
    try {
      final res = await dioClient.post(ApiConst.register, data: map);
      if (res.data['response']['code'] != 200) {
        throw ServerException(res.data['response']['message']);
      }
      return UserModel.fromMap(res.data['data']);
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
  Future<UserModel> getUser({required String token}) async {
    try {
      final res = await dioClient.get(ApiConst.profile, Options(headers: {'Authorization': 'Bearer $token'}));
      if (res.data['response']['code'] != 200) {
        throw ServerException(res.data['response']['message']);
      }
      return UserModel.fromMap(res.data['data']);
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
  Future<UserModel> uploadPhoto({required String imagePath, required String token}) async {
    try {
      final res = await dioClient.post(
        ApiConst.uploadPhoto,
        data: FormData.fromMap({'file': await MultipartFile.fromFile(imagePath)}),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (res.data['response']['code'] != 200) {
        throw ServerException(res.data['response']['message']);
      }
      return UserModel.fromMap(res.data['data']);
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
