import 'package:easy_localization/easy_localization.dart';

import '../lang/locale_keys.g.dart';

class AppValidator {
  const AppValidator._();

  static const mustNotEmptyKey = LocaleKeys.mustNotEmpty;
  static const invalidEmail = LocaleKeys.invalidEmail;
  static const passwordsNotMatch = LocaleKeys.passwordsNotMatch;
  static const enterPasswordFirst = LocaleKeys.enterPasswordFirst;

  static final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  static String? blankValidator(String? value) {
    if (value == null) return mustNotEmptyKey.tr();
    if (value.isEmpty) return mustNotEmptyKey.tr();
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null) return mustNotEmptyKey.tr();
    if (value.isEmpty) return mustNotEmptyKey.tr();
    if (!emailRegex.hasMatch(value)) return invalidEmail.tr();
    return null;
  }

  static String? passwordAgainValidator(String? value, String? first) {
    if (value == null) return mustNotEmptyKey.tr();
    if (value.isEmpty) return mustNotEmptyKey.tr();
    if (first == null || first.isEmpty) return enterPasswordFirst.tr();
    if (value != first) return passwordsNotMatch.tr();
    return null;
  }
}
