import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [num] değerler ile [EdgeInsets] oluşturan yardımcı
extension NumToEdgeInsetsExt on num {
  EdgeInsets get allPad => EdgeInsets.all(toDouble()).r;

  EdgeInsets get verticalPad => EdgeInsets.symmetric(vertical: toDouble()).r;
  EdgeInsets get horizontalPad => EdgeInsets.symmetric(horizontal: toDouble()).r;

  EdgeInsets get topPad => EdgeInsets.only(top: toDouble()).r;
  EdgeInsets get leftPad => EdgeInsets.only(left: toDouble()).r;
  EdgeInsets get rightPad => EdgeInsets.only(right: toDouble()).r;
  EdgeInsets get botPad => EdgeInsets.only(bottom: toDouble()).r;
}

extension MediaQueryPaddingExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  EdgeInsets get screenPadding => mediaQuery.viewPadding;
  EdgeInsets get statusBarPadding => EdgeInsets.only(top: mediaQuery.viewPadding.top);
  EdgeInsets get systemNavBarPadding => EdgeInsets.only(bottom: mediaQuery.viewPadding.bottom);

  SizedBox get statusBarBox => SizedBox(height: statusBarPadding.top);
  SizedBox get systemNavBarBox => SizedBox(height: systemNavBarPadding.bottom);
}
