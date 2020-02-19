import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';

abstract class TabBarPageWidget extends BasePageWidget{}

abstract class TabBarPageWidgetState<T extends TabBarPageWidget> extends BasePageWidgetState<T> {
  int _tabIndex = 0;
  Color fixedColor = Colors.black;
  double selectedFontSize = 15.0;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: getPageList()[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: getMenuList(),
          currentIndex: _tabIndex,
          fixedColor: fixedColor,
          selectedFontSize: selectedFontSize,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          }),
    );
  }

  List getPageList();
  List<BottomNavigationBarItem> getMenuList();
}
