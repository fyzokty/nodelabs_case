import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/fail.dart';
import '../../../../shared/entity/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_local_data_source.dart';
import '../datasource/auth_remote_data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.authRemoteDataSource, required this.authLocalDataSource});

  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  Future<String?> _getToken() async {
    return await authLocalDataSource.readToken();
  }

  @override
  Future<Either<Fail, UserModel>> login({required String email, required String password}) async {
    try {
      final userModel = await authRemoteDataSource.login(email: email, password: password);
      await authLocalDataSource.writeToken(userModel.token!);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Fail(e.message));
    }
  }

  @override
  Future<Either<Fail, UserModel>> register({
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authRemoteDataSource.register(fullname: fullname, email: email, password: password);
      await authLocalDataSource.writeToken(userModel.token!);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Fail(e.message));
    }
  }

  @override
  Future<Either<Fail, User>> getUser() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return left(Fail('TOKEN_NULL'));
      }
      final userModel = await authRemoteDataSource.getUser(token: token);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Fail(e.message));
    }
  }

  @override
  Future<Either<Fail, User>> uploadPhoto({required String imagePath}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        return left(Fail('TOKEN_NULL'));
      }
      UserModel userModel = await authRemoteDataSource.uploadPhoto(imagePath: imagePath, token: token);
      if (userModel.token == null) {
        userModel = userModel.copyWith(token: token);
      }
      return right(userModel);
    } on ServerException catch (e) {
      return left(Fail(e.message));
    }
  }

  @override
  Future<void> logout() async {
    await authLocalDataSource.deleteToken();
  }
}
