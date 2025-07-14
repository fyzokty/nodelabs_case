import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../lang/locale_keys.g.dart';

void showError(String text) {
  toastification.show(
    style: ToastificationStyle.flat,
    autoCloseDuration: Duration(seconds: 5),
    alignment: Alignment.topCenter,
    animationBuilder: NotificationConst._defaultAnimationBuilder,
    title: Text(LocaleKeys.error.tr()),
    description: Text(text),
    type: ToastificationType.error,
  );
}

void showInfo(String text) {
  toastification.show(
    style: ToastificationStyle.flat,
    autoCloseDuration: Duration(seconds: 5),
    alignment: Alignment.topCenter,
    animationBuilder: NotificationConst._defaultAnimationBuilder,
    description: Text(text),
    type: ToastificationType.info,
  );
}

class NotificationConst {
  static Widget _defaultAnimationBuilder(
    BuildContext context,
    Animation<double> animation,
    Alignment alignment,
    Widget child,
  ) {
    final curvedAnim = CurvedAnimation(parent: animation, curve: Curves.easeIn);
    Tween<Offset> offset = Tween<Offset>(begin: Offset(0, -1.2), end: Offset.zero);
    if (alignment == Alignment.bottomCenter) {
      offset = Tween<Offset>(begin: Offset(0, 1.2), end: Offset.zero);
    }
    return SlideTransition(
      position: offset.animate(curvedAnim),
      child: FadeTransition(opacity: curvedAnim, child: child),
    );
  }
}
