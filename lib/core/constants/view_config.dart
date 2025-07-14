import 'package:flutter/material.dart';

import 'colors.dart';

class ViewConfigConst {
  const ViewConfigConst._();

  static const forwardCurve = Easing.emphasizedDecelerate;
  static const reverseCurve = Easing.emphasizedAccelerate;

  static const radiusSmall = Radius.circular(18);
  static const radiusBig = Radius.circular(32);

  static const borderRadiusSmall = BorderRadius.all(radiusSmall);
  static const borderRadiusBig = BorderRadius.all(radiusBig);

  static const borderSideGrey = BorderSide(color: ColorConst.fieldStroke);
  static const borderSideWhite = BorderSide(color: ColorConst.white);
  static const borderSideRed = BorderSide(color: ColorConst.mainRed);

  static const screenHorizontalPadding = EdgeInsets.symmetric(horizontal: 40);
}
