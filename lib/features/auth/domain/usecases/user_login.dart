import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/entity/user.dart';
import '../repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  const UserLogin(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<Either<Fail, User>> call(params) async {
    return await authRepository.login(email: params.email, password: params.password);
  }
}

class UserLoginParams {
  const UserLoginParams({required this.email, required this.password});
  final String email;
  final String password;
}
