import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/res/app_colors.dart';
import 'package:flutter_app/res/styles.dart';

class ThemeProvider extends ChangeNotifier {

  static const Map<ThemeMode, String> themes = {
    ThemeMode.dark: 'Dark',
    ThemeMode.light : 'Light'
  };

  void setTheme(ThemeMode themeMode) {
    Global.profile.theme = themes[themeMode];
    notifyListeners();
  }

  ThemeMode getThemeMode(){
    if (Global.profile.theme == themes[ThemeMode.dark]) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  // 参数参考链接：https://juejin.im/post/5d751714f265da03ad14765c
  getTheme({bool isDarkMode: false}) {
    return ThemeData(
      // 亮度[深色还是浅色]
      brightness: isDarkMode ? Brightness.dark : Brightness.light, // 应用程序整体主题的亮度。用于按钮等小部件，以确定在不使用主色（primaryColor）或强调色（accentColor）时选择什么颜色。
      primaryColorBrightness: isDarkMode ? Brightness.dark : Brightness.dark, // 用于确定放置在主要颜色上方的文本和图标的颜色（例如，导航栏，工具栏文本）
      accentColorBrightness: isDarkMode ? Brightness.dark : Brightness.light,  // 用于确定放置在强调颜色上方的文本和图标的颜色（例如，浮动操作按钮上的图标）

      // 应用程序主要部分的颜色
      primaryColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main, // 应用程序主要部分（工具栏，标签栏等）的背景颜色
      accentColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main, // 主题次级色，决定大多数Widget的颜色，如进度条、开关等
      indicatorColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main,  // Tab指示器颜色

      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? AppColors.dark_bg_color : AppColors.bg_color,

      // 导航栏颜色
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          textTheme: TextTheme(
            title: isDarkMode ? TextStyles.darkNavTitleText : TextStyles.navTitleText, // 导航栏文本颜色
          ),
          color: isDarkMode ? AppColors.dark_nav_bg : AppColors.nav_bg,  // 导航栏背景颜色
          brightness: isDarkMode ? Brightness.dark : Brightness.light,  // 状态栏文本颜色
          iconTheme: IconThemeData(
            color: isDarkMode ? AppColors.dark_icon : AppColors.icon,
          )
      ),

      // 按钮颜色
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,  // 按钮文本颜色，根据亮度自动选择深色或者浅色
        buttonColor: isDarkMode ? AppColors.dark_button_bg : AppColors.button_bg, // 按钮背景颜色
      ),

      // 图标颜色和大小
      iconTheme: IconThemeData(
        color: isDarkMode ? AppColors.dark_icon : AppColors.icon,
        size: 24.0
      ),

      // 控件颜色设置
      disabledColor: Colors.grey,  // 无效的部件(widget)的颜色，不管它们的状态如何。例如，一个禁用的复选框(可以选中或不选中)。
      unselectedWidgetColor:  isDarkMode ? AppColors.dark_app_main : AppColors.app_main,  // 小部件处于非活动(但启用)状态时使用的颜色。例如，未选中的复选框。通常与accentColor形成对比。
      toggleableActiveColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main, // 用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色。
      backgroundColor: Colors.grey, // 与primaryColor对比的颜色(例如 用作进度条的剩余部分)

      // 字体主题，包括标题、body等文字样式
      textTheme: TextTheme(
        title: isDarkMode ? TextStyles.darkTitleText : TextStyles.titleText,// 用于应用程序栏和对话框中title的主要文本（例如AppBar.title 和AlertDialog.title）
        headline: isDarkMode ? TextStyles.darkListTitleText : TextStyles.listTitleText,  // 用于对话框中的大文本（例如，showDatePicker显示的对话框中的月份和年份）
        subhead: isDarkMode ? TextStyles.darkListTitleText : TextStyles.listTitleText, // 用于列表中的主要文本（例如ListTile.title）。
        subtitle: isDarkMode ? TextStyles.darkListSubTitleText : TextStyles.listSubTitleText, // 对于中等偏重的文本，该文本要比subhead小一些
        body1: isDarkMode ? TextStyles.darkBodyText : TextStyles.bodyText,  // 正文文字样式，用于Material的默认文本样式
      ),

      // 分割线颜色
//      dividerColor: isDarkMode ? AppColors.dark_line : AppColors.line,
//      dividerTheme: DividerThemeData(
//          color: isDarkMode ? AppColors.dark_line : AppColors.line,
//          space: 0.6,
//          thickness: 0.6
//      ),
//
//      // 错误红色
//      errorColor: isDarkMode ? AppColors.dark_red : AppColors.red,
//
//      // 文字选择色（输入框复制粘贴菜单）
//      textSelectionColor: AppColors.app_main.withAlpha(70),
//      textSelectionHandleColor: AppColors.app_main,
//
//
//      inputDecorationTheme: InputDecorationTheme(
//        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
//      ),
//
//
//      cupertinoOverrideTheme: CupertinoThemeData(
//        brightness: isDarkMode ? Brightness.dark : Brightness.light,
//      ),

    );
  }

}
