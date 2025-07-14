part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthRegister extends AuthEvent {
  AuthRegister({required this.fullname, required this.email, required this.password});

  final String fullname;
  final String email;
  final String password;
}

final class AuthLogin extends AuthEvent {
  AuthLogin({required this.email, required this.password});

  final String email;
  final String password;
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthUploadPhoto extends AuthEvent {
  AuthUploadPhoto({required this.imagePath});

  final String imagePath;
}

final class AuthLogOut extends AuthEvent {}
