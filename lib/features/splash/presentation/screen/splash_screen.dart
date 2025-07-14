import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/asset.dart';
import '../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../shared/widget/loading_indicator.dart';
import '../../../../shared/widget/navigatable.dart';
import '../../../../shared/widget/scaffold.dart';
import 'mixin/splash_screen_mixin.dart';

class SplashScreen extends StatefulWidget implements Navigatable {
  const SplashScreen({super.key});

  @override
  String get name => 'Splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashScreenMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocListener<AppUserCubit, AppUserState>(
        listener: appUserListener,
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(AssetConst.appSplashPNG, fit: BoxFit.cover)),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(child: Padding(padding: EdgeInsets.only(bottom: 30).r, child: LoadingIndicator())),
            ),
          ],
        ),
      ),
    );
  }
}
