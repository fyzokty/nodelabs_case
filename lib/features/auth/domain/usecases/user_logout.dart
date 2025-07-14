import '../repository/auth_repository.dart';

class UserLogouUseCase {
  const UserLogouUseCase(this.authRepository);
  final AuthRepository authRepository;

  Future<void> logOut() async {
    await authRepository.logout();
  }
}
