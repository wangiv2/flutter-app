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
      _screenHeight = MediaQuery.of(_context).size.height - 187;
    }
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
    return _statusBarHeight;
  }
}
