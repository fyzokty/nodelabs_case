import 'package:fpdart/fpdart.dart';

import '../../../../core/error/fail.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/entity/user.dart';
import '../repository/auth_repository.dart';

class UserUploadPhoto implements UseCase<User, UserUploadPhotoParams> {
  const UserUploadPhoto(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<Either<Fail, User>> call(UserUploadPhotoParams params) async {
    return await authRepository.uploadPhoto(imagePath: params.imagePath);
  }
}

class UserUploadPhotoParams {
  const UserUploadPhotoParams({required this.imagePath});

  final String imagePath;
}
