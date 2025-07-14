import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'view_config.dart';

class ThemeConst {
  const ThemeConst._();

  static final theme = ThemeData(
    primaryColor: ColorConst.mainRed,
    scaffoldBackgroundColor: ColorConst.background,
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Euclid',
    fontFamilyFallback: ['NotoSans'],
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(backgroundColor: ColorConst.background),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConst.fieldFill,
      focusColor: ColorConst.white,
      hintStyle: TextStyle(fontSize: 12, color: ColorConst.greyText),
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      border: OutlineInputBorder(
        borderRadius: ViewConfigConst.borderRadiusSmall,
        borderSide: ViewConfigConst.borderSideGrey,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: ViewConfigConst.borderRadiusSmall,
        borderSide: ViewConfigConst.borderSideGrey,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: ViewConfigConst.borderRadiusSmall,
        borderSide: ViewConfigConst.borderSideRed,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: ViewConfigConst.borderRadiusSmall,
        borderSide: ViewConfigConst.borderSideWhite.copyWith(width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: ViewConfigConst.borderRadiusSmall,
        borderSide: ViewConfigConst.borderSideRed.copyWith(width: 2),
      ),
    ),
  );
}
