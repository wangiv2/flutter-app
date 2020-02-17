import 'package:flutter/material.dart';
import 'package:flutter_app/pages/chat/chat_page.dart';
import 'package:flutter_app/pages/me/me_page.dart';
import 'package:flutter_app/pages/menu/menu_page.dart';
import 'package:flutter_app/utils/index.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BaseFunction {
  int _tabIndex = 0;

  List<BottomNavigationBarItem> _getMenuList() {
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

  List _pageList = [
    new MenuPage(),
    new ChatPage(),
    new MePage(),
  ];

  @override
  void initState() {
    initBaseFunction(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: _getMenuList(),
          currentIndex: _tabIndex,
          fixedColor: Colors.deepPurple,
          selectedFontSize: 15.0,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          }),
    );
  }
}
