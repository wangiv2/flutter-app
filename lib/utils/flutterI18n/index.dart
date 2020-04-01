import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

class FlutterI18nUtil {
  BuildContext _context;
  static String _defaultLang = 'en';
  static String _localesPath = 'assets/locales';

  FlutterI18nUtil(BuildContext context) {
    _context = context;
  }

  static FlutterI18nDelegate delegate (String lang) {
    return FlutterI18nDelegate(
        useCountryCode: false,
        fallbackFile: _defaultLang,
        path: _localesPath,
        forcedLocale: new Locale(lang == null ? _defaultLang : lang)
    );
  }

  Locale get currentLocale {
    return FlutterI18n.currentLocale(_context);
  }

  String translate(String key, {int pluralValue}) {
    if (pluralValue != null) {
      return FlutterI18n.plural(_context, key, pluralValue);
    } else {
      return FlutterI18n.translate(_context, key);
    }
  }

  void refresh({String lang, Locale locale}) {
    if (lang != null) {
      FlutterI18n.refresh(_context, new Locale(lang));
    } else if (locale != null) {
      FlutterI18n.refresh(_context, locale);
    }
  }
}
