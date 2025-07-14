import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/lang/locale_keys.g.dart';
import '../../../../../core/service/navigation_service.dart';
import '../../../../../core/util/show_notification.dart';
import '../../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../home/presentation/screen/home.dart';
import '../../bloc/auth_bloc.dart';
import '../login.dart';
import '../register.dart';

mixin LoginScreenMixin on State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalObjectKey('loginForm');

  final emailCont = TextEditingController();
  final passwordCont = TextEditingController();

  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  final ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> formFocused = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    emailNode.addListener(_focusStatusListener);
    passwordNode.addListener(_focusStatusListener);
  }

  @override
  void dispose() {
    emailNode.removeListener(_focusStatusListener);
    emailNode.dispose();
    passwordNode.removeListener(_focusStatusListener);
    passwordNode.dispose();
    super.dispose();
  }

  void authBlocListener(BuildContext _, AuthState state) {
    log('AppUserState: $state');
    if (state is AuthFailure) {
      showError(state.message.tr());
    }
    if (state is AuthSuccess) {
      showInfo('${LocaleKeys.wellcome.tr()} ${state.user.name}');
    }
  }

  void appUserListener(BuildContext _, AppUserState state) {
    log('AppUserState: $state');
    if (state is AppUserLoggedIn) {
      NavigationService.pushAndRemoveUntil(HomeScreen());
    }
  }

  void _focusStatusListener() {
    final anyFieldsHasFocus = emailNode.hasFocus || passwordNode.hasFocus;

    if (formFocused.value == anyFieldsHasFocus) return;
    formFocused.value = anyFieldsHasFocus;
  }

  void loginOnTap() {
    if (!formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(AuthLogin(email: emailCont.text.trim(), password: passwordCont.text.trim()));
  }

  void hideOnTap() {
    obscurePassword.value = !obscurePassword.value;
  }

  void navigateAddPhoto() {
    NavigationService.push(RegisterScreen());
  }

  void registerOnTap() {
    NavigationService.pushReplacement(RegisterScreen());
  }
}
