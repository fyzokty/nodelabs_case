import '../lang/locale_keys.g.dart';

class Fail {
  const Fail([this.text = LocaleKeys.unexpectedError]);

  final String text;
}
