import 'package:flutter/material.dart';
import 'package:flutter_app/pages/chat/chat_page.dart';
import 'package:flutter_app/pages/me/pages/me_page.dart';
import 'package:flutter_app/pages/menu/menu_page.dart';
import 'package:flutter_app/widgets/base_page_widget/tabBar_page_widget.dart';

class HomePage extends TabBarPageWidget {
  @override
  String getPageName() => "HomePage";

  @override
  TabBarPageWidgetState<TabBarPageWidget> getState() => _HomePageState();
}

class _HomePageState extends TabBarPageWidgetState<HomePage> {

  @override
  void onCreate() {
    super.onCreate();
  }

  @override
  List<BottomNavigationBarItem> getMenuList() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title:
              Text(flutterI18nUtil.translate("homePage.tabTitles.menu"))),
      BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title:
              Text(flutterI18nUtil.translate("homePage.tabTitles.chat"))),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title:
              Text(flutterI18nUtil.translate("homePage.tabTitles.me"))),
    ];
  }

  @override
  List getPageList() {
    return [
      new MenuPage(),
      new ChatPage(),
      new MePage(),
    ];
  }
}
