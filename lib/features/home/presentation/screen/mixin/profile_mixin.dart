import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/service/navigation_service.dart';
import '../../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/screen/login.dart';
import '../../widget/limited_offer_bottom_sheet.dart';
import '../profile.dart';

mixin ProfileMixin on State<ProfilePage> {
  void limitedOfferOnTap() {
    NavigationService.showModalBottomSheet(LimitedOfferBottomSheet());
  }

  void logoutOnTap() {
    context.read<AuthBloc>().add(AuthLogOut());
  }

  void languageOnTap() {
    final locale = context.locale;
    if (locale.languageCode == 'tr') {
      context.setLocale(Locale('en'));
      return;
    }
    context.setLocale(Locale('tr'));
  }

  void appUserListener(context, state) {
    if (state is AppUserInitial) {
      NavigationService.pushAndRemoveUntil(LoginScreen());
    }
  }
}
