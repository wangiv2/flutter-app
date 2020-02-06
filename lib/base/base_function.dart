import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'base_page_widget.dart';

abstract class BaseFunction {
  BuildContext _context;
  void setContextToBaseFunction(State state) {
    _context = state.context;
  }
  double getScreenHeight() {
    // kToolbarHeight, kBottomNavigationBarHeight
    return MediaQuery.of(_context).size.height - 187;
  }
  double getScreenWidth() {
    return MediaQuery.of(_context).size.width;
  }
  double getStatusBarHeight() {
    return MediaQuery.of(_context).padding.top;
  }
  void log(Object object) {
    BasePageWidget basePageWidget = _context.widget;
    print("[$basePageWidget] - $object");
  }
  String i18nTranslate(String key, {int pluralValue}) {
    if (pluralValue != null) {
      return FlutterI18n.plural(_context, key, pluralValue);
    } else {
      return FlutterI18n.translate(_context, key);
    }
  }
}
