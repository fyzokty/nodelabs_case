import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../shared/entity/user.dart';

abstract interface class AuthRepository {
  Future<Either<Fail, User>> login({required String email, required String password});

  Future<Either<Fail, User>> register({required String fullname, required String email, required String password});

  Future<Either<Fail, User>> getUser();

  Future<Either<Fail, User>> uploadPhoto({required String imagePath});

  Future<void> logout();
}
