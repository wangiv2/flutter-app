import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/res/app_colors.dart';
import 'package:flutter_app/res/styles.dart';

class ThemeProvider extends ChangeNotifier {

  static const Map<ThemeMode, String> themes = {
    ThemeMode.dark: 'Dark', ThemeMode.light : 'Light'
  };

  void setTheme(ThemeMode themeMode) {
    Global.profile.theme = themes[themeMode];
    notifyListeners();
  }

  ThemeMode getThemeMode(){
    String theme = Global.profile.theme;
    if (theme == 'Dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  getTheme({bool isDarkMode: false}) {
    return ThemeData(
      errorColor: isDarkMode ? AppColors.dark_red : AppColors.red,
      // 深色还是浅色
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      // 主题主色，决定导航栏颜色
      primaryColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main,
      // 主题次级色，决定大多数Widget的颜色，如进度条、开关等
      accentColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? AppColors.dark_bg_color : AppColors.bg_color,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? AppColors.dark_bg_color : AppColors.bg_color,
      // 文字选择色（输入框复制粘贴菜单）
      textSelectionColor: AppColors.app_main.withAlpha(70),
      textSelectionHandleColor: AppColors.app_main,
      // 字体主题，包括标题、body等文字样式
      textTheme: TextTheme(
        // TextField输入文字颜色
        subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文字样式
        body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? AppColors.dark_bg_color : AppColors.app_main,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      // 分割线颜色
      dividerTheme: DividerThemeData(
        color: isDarkMode ? AppColors.dark_line : AppColors.line,
        space: 0.6,
        thickness: 0.6
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: isDarkMode ? AppColors.dark_button_bg : AppColors.button_bg,
      ),
    );
  }

}
