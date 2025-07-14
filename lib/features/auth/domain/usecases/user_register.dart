import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/entity/user.dart';
import '../repository/auth_repository.dart';

class UserRegister implements UseCase<User, UserRegisterParams> {
  const UserRegister(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<Either<Fail, User>> call(UserRegisterParams params) async {
    return await authRepository.register(fullname: params.fullname, email: params.email, password: params.password);
  }
}

class UserRegisterParams {
  const UserRegisterParams({required this.fullname, required this.email, required this.password});
  final String fullname;
  final String email;
  final String password;
}
