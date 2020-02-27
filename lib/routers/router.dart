import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/menu/opportunity_page.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/language_list_page/language_list_page.dart';

class Router {
  static final Map<String, WidgetBuilder> routers = {
    HomePage().getPageName(): (context) => HomePage(),
    OpportunityPage().getPageName(): (context) => OpportunityPage(),
    LanguageListPage().getPageName(): (context) => LanguageListPage(),
  };

  static Future<T> pushPage<T extends Object>(BuildContext context, BasePageWidget page, {Object params}) {
    return Navigator.pushNamed(context, page.getPageName(), arguments: params);
  }

  static void popPage(BuildContext context, {Object params}) {
    Navigator.pop(context, params);
  }

  static Object getPageParams(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }
}

class RouterManager {
  List<String> _activityStack = new List<String>();

  RouterManager._internal();

  static RouterManager _singleton = new RouterManager._internal();

  //工厂模式
  factory RouterManager() => _singleton;
  void addWidget(BasePageWidget page) {
    _activityStack.add(page.getPageName());
  }

  void removeWidget(BasePageWidget page) {
    _activityStack.remove(page.getPageName());
  }

  bool isTopPage(BasePageWidget page) {
    if (_activityStack == null) {
      return false;
    }
    try {
      return page.getPageName() ==
          _activityStack[_activityStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  bool isSecondTop(BasePageWidget page) {
    if (_activityStack == null) {
      return false;
    }
    try {
      return page.getPageName() ==
          _activityStack[_activityStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}
