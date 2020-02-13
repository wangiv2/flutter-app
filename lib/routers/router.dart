import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/base/base_page_widget.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/widgets/language_list_page/language_list_page.dart';

class Router {
  static final Map<String, WidgetBuilder> routers = {
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
