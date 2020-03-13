import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';
import 'package:flutter_app/utils/screen/index.dart';

abstract class BaseUtils {
  BuildContext _context;

  ScreenUtil _screenUtil;
  FlutterI18nUtil _flutterI18nUtil;

  void initBaseUtils(BuildContext context) {
    _context = context;
    if(_screenUtil == null) _screenUtil = new ScreenUtil(_context);
    if(_flutterI18nUtil == null) _flutterI18nUtil = new FlutterI18nUtil(_context);
  }

  ScreenUtil get screenUtil => _screenUtil;
  FlutterI18nUtil get flutterI18nUtil => _flutterI18nUtil;

}
