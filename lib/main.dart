import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import 'core/constants/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/splash/presentation/screen/splash_screen.dart';
import 'service_locator.dart';
import 'core/service/navigation_service.dart';
import 'shared/cubits/app_user/app_user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: [Locale('tr'), Locale('en')],
      fallbackLocale: Locale('en'),
      path: 'asset/lang',
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
          BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
          BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        ],
        child: const SinFlixApp(),
      ),
    ),
  );
}

class SinFlixApp extends StatelessWidget {
  const SinFlixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(402, 844),
      builder: (context, child) {
        return child!;
      },
      child: ToastificationWrapper(
        child: MaterialApp(
          title: 'SinFlix',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeConst.theme,
          navigatorKey: NavigationService.navKey,
          home: const SplashScreen(),
          builder: (context, splash) {
            return MediaQuery(data: MediaQuery.of(context), child: splash!);
          },
        ),
      ),
    );
  }
}
