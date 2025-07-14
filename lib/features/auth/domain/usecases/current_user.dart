import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/entity/user.dart';
import '../repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  const CurrentUser(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<Either<Fail, User>> call(NoParams params) async {
    return await authRepository.getUser();
  }
}
