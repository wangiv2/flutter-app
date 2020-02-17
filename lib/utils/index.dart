import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';
import 'package:flutter_app/utils/screen/index.dart';
import 'package:flutter_app/utils/share_preferences/index.dart';

import '../widgets/base_page_widget/base_page_widget.dart';

abstract class BaseFunction {
  BuildContext _context;
  ScreenUtil _screenUtil;
  SharePreferencesUtil _sharePreferencesUtil;
  FlutterI18nUtil _flutterI18nUtil;

  void initBaseFunction(State state) {
    _context = state.context;
    _screenUtil = new ScreenUtil(_context);
    _sharePreferencesUtil = new SharePreferencesUtil();
    _flutterI18nUtil = new FlutterI18nUtil(_context);
  }

  ScreenUtil get screenUtil => _screenUtil;
  SharePreferencesUtil get sharePreferencesUtil => _sharePreferencesUtil;
  FlutterI18nUtil get flutterI18nUtil => _flutterI18nUtil;

  void log(Object object) {
    BasePageWidget basePageWidget = _context.widget;
    print("[$basePageWidget] - $object");
  }
}
