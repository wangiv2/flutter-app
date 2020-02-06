import 'package:flutter/material.dart';
import 'package:flutter_app/base/base_function.dart';
import 'package:flutter_app/pages/chat_page.dart';
import 'package:flutter_app/pages/me_page.dart';
import 'package:flutter_app/pages/menu_page.dart';

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
              Text(i18nTranslate("homePage.tabTitles.menu"))),
      BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title:
              Text(i18nTranslate("homePage.tabTitles.chat"))),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title:
              Text(i18nTranslate("homePage.tabTitles.me"))),
    ];
  }

  List _pageList = [
    new MenuPage(),
    new ChatPage(),
    new MePage(),
  ];

  @override
  void initState() {
    setContextToBaseFunction(this);
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
