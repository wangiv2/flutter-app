import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/provider/profile_provider.dart';
import 'package:flutter_app/provider/theme_provider.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:provider/provider.dart';

abstract class Funs {
  BuildContext _context;

  void initFuns(BuildContext context) {
    _context = context;
  }

  void consoleLog(Object object) {
    BasePageWidget basePageWidget = _context.widget;
    print("[$basePageWidget] - $object");
  }

  ProfileProvider profileProvider({bool listen = true}) {
    return Provider.of<ProfileProvider>(_context, listen: listen);
  }

  ThemeProvider themeProvider({bool listen = true}) {
    return Provider.of<ThemeProvider>(_context, listen: listen);
  }

  static bool isDarkTheme() {
    return Global.profile.theme == ThemeProvider.themes[ThemeMode.dark];
  }
}
