import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';

class RouterStack {
  List<String> _routerStack = new List<String>();

  RouterStack._internal();

  static RouterStack _singleton = new RouterStack._internal();

  //工厂模式
  factory RouterStack() => _singleton;
  void addWidget(BasePageWidget page) {
    _routerStack.add(page.getPageName());
  }

  void removeWidget(BasePageWidget page) {
    _routerStack.remove(page.getPageName());
  }

  bool isTopPage(BasePageWidget page) {
    if (_routerStack == null) {
      return false;
    }
    try {
      return page.getPageName() ==
          _routerStack[_routerStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  bool isSecondTop(BasePageWidget page) {
    if (_routerStack == null) {
      return false;
    }
    try {
      return page.getPageName() ==
          _routerStack[_routerStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}
