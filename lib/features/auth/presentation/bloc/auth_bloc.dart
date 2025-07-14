import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../shared/entity/user.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_register.dart';
import '../../domain/usecases/user_upload_photo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegister _userRegister;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserUploadPhoto _userUploadPhoto;

  AuthBloc({
    required UserRegister userRegister,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserUploadPhoto userUploadPhoto,
  }) : _userRegister = userRegister,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       _userUploadPhoto = userUploadPhoto,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthRegister>(_onAuthRegister);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthUploadPhoto>(_onAuthUploadPhoto);
    on<AuthLogOut>(_onAuthLogout);
  }

  void _onAuthRegister(AuthRegister event, Emitter<AuthState> emit) async {
    final res = await _userRegister(
      UserRegisterParams(fullname: event.fullname, email: event.email, password: event.password),
    );

    res.fold((fail) => emit(AuthFailure(fail.text)), (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(UserLoginParams(email: event.email, password: event.password));

    res.fold((fail) => emit(AuthFailure(fail.text)), (user) => _emitAuthSuccess(user, emit));
  }

  void _isUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((fail) {
      emit(AuthFailure(fail.text));
      _appUserCubit.updateUser(null);
    }, (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthUploadPhoto(AuthUploadPhoto event, Emitter<AuthState> emit) async {
    final res = await _userUploadPhoto(UserUploadPhotoParams(imagePath: event.imagePath));

    res.fold((fail) => emit(AuthFailure(fail.text)), (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  FutureOr<void> _onAuthLogout(AuthLogOut event, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(null);
    emit(AuthInitial());
  }
}
