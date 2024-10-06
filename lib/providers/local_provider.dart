import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLocal(String localeCode) {
    _locale = Locale(localeCode);
    notifyListeners();
  }

  static LocaleProvider get(BuildContext context) {
    return context.read<LocaleProvider>();
  }
}
