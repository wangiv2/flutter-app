import 'package:flutter/material.dart';
import 'package:flutter_app/utils/screen/index.dart';
import 'package:flutter_app/utils/share_preferences/index.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'base_page_widget.dart';

abstract class BaseFunction {
  BuildContext _context;
  ScreenUtil _screenUtil;
  SharePreferencesUtil _sharePreferencesUtil;
  void initBaseFunction(State state) {
    _context = state.context;
    _screenUtil = new ScreenUtil(_context);
    _sharePreferencesUtil = new SharePreferencesUtil();
  }

  ScreenUtil get screenUtil => _screenUtil;
  SharePreferencesUtil get sharePreferencesUtil => _sharePreferencesUtil;

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
