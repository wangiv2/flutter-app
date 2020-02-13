import 'package:flutter/material.dart';
import 'package:flutter_app/base/base_function.dart';
import 'package:flutter_app/model/user_preference_entity.dart';
import 'package:flutter_app/pages/chat/chat_page.dart';
import 'package:flutter_app/pages/me/me_page.dart';
import 'package:flutter_app/pages/menu/menu_page.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
    initBaseFunction(this);
    _printUserPref();
    super.initState();
  }

  void _printUserPref() async {
    UserPreferenceEntity userPref = await sharePreferencesUtil.getUserPreference();
    print("userPref.language: ${userPref.language}");
    FlutterI18n.refresh(context, new Locale(userPref.language));
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
