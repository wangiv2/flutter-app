import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';

abstract class TabBarPageWidget extends BasePageWidget{}

abstract class TabBarPageWidgetState<T extends TabBarPageWidget> extends BasePageWidgetState<T> {
  // interfaces
  void onTabChanged(int _index) {}
  List getPageList();
  List<BottomNavigationBarItem> getMenuList();

  // Internal properties and methods
  int _tabIndex = 0;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: getPageList()[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: getMenuList(),
          currentIndex: _tabIndex,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
            onTabChanged(_tabIndex);
          }),
    );
  }
}
