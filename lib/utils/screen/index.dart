import 'package:flutter/material.dart';

class ScreenUtil {
  BuildContext _context;
  double _screenHeight, _screenWidth, _statusBarHeight;

  ScreenUtil(BuildContext context) {
    _context = context;
  }

  double get screenHeight {
    if (_screenHeight == null) {
      // kToolbarHeight, kBottomNavigationBarHeight
      _screenHeight = MediaQuery.of(_context).size.height;
    }
    print("screenHeight: $_screenHeight");
    return _screenHeight;
  }

  double get screenWidth {
    if (_screenWidth == null) {
      _screenWidth = MediaQuery.of(_context).size.width;
    }
    return _screenWidth;
  }

  double get statusBarHeight {
    if (_statusBarHeight == null) {
      _statusBarHeight = MediaQuery.of(_context).padding.top;
    }
    print("statusBarHeight: $_statusBarHeight");
    return _statusBarHeight;
  }

  double get navigationBarHeight {
    print("navigationBarHeight: $kToolbarHeight");
    return kToolbarHeight;
  }

  double get bottomTabBarHeight {
    print("bottomTabBarHeight: $kBottomNavigationBarHeight");
    // 56.0
    return kBottomNavigationBarHeight;
  }
}
