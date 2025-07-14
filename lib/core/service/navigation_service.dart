import 'package:flutter/material.dart';

import '../../shared/widget/navigatable.dart';

class NavigationService {
  const NavigationService._();

  static GlobalKey<NavigatorState> navKey = GlobalObjectKey<NavigatorState>('base-navigator');

  static NavigatorState get state => navKey.currentState!;

  static Future<T?> push<T>(Navigatable screen, {Object? arguments}) async {
    final T? result = await state.push(
      MaterialPageRoute(builder: (context) => screen, settings: RouteSettings(name: screen.name, arguments: arguments)),
    );

    return result;
  }

  static Future<T?> popAndPush<T>(Navigatable screen, {Object? arguments}) async {
    state.pop();
    final T? result = await state.push(
      MaterialPageRoute(builder: (context) => screen, settings: RouteSettings(name: screen.name, arguments: arguments)),
    );

    return result;
  }

  static void popUntil(bool Function(Route<dynamic> route) predicate) {
    state.popUntil(predicate);
  }

  static Future<T?> pushAndRemoveUntil<T>(Navigatable screen, {RoutePredicate? predicate, Object? arguments}) async {
    final T? result = await state.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen, settings: RouteSettings(arguments: arguments, name: screen.name)),
      predicate ?? (route) => false,
    );
    return result;
  }

  static Future<T?> pushReplacement<T>(Navigatable screen, {RoutePredicate? predicate, Object? arguments}) async {
    final T? result = await state.pushReplacement(
      MaterialPageRoute(builder: (context) => screen, settings: RouteSettings(arguments: arguments, name: screen.name)),
    );
    return result;
  }

  static Future<T?> showModalBottomSheet<T extends Object?>(
    Navigatable bottomSheet, {
    bool isScrollControlled = true,
    bool isDissmissible = true,
    bool enableDrag = true,
  }) async {
    return state.push(
      ModalBottomSheetRoute(
        builder: (context) => bottomSheet,
        isScrollControlled: isScrollControlled,
        showDragHandle: false,
        backgroundColor: Colors.transparent,
        isDismissible: isDissmissible,
        enableDrag: enableDrag,
      ),
    );
  }

  static void pop<T>([T? result]) => state.pop(result);
}
