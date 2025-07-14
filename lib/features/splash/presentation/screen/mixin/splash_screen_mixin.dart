import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/service/navigation_service.dart';
import '../../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/screen/login.dart';
import '../../../../home/presentation/screen/home.dart';
import '../splash_screen.dart';

mixin SplashScreenMixin on State<SplashScreen> {
  @override
  void initState() {
    splashInit();
    super.initState();
  }

  void splashInit() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  void appUserListener(BuildContext _, AppUserState state) async {
    log('AppUserState: $state');
    await Future.delayed(Duration(seconds: 3));
    if (state is AppUserLoggedIn) {
      NavigationService.pushAndRemoveUntil(HomeScreen());
      return;
    }
    NavigationService.pushAndRemoveUntil(LoginScreen());
  }
}
