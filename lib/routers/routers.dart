
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/pages/home_page.dart';
import 'package:flutter_app/pages/me/router.dart';
import 'package:flutter_app/pages/opportunity/router.dart';
import 'package:flutter_app/widgets/base_page_widget/webview_page.dart';
import 'package:flutter_app/widgets/error_page_widget/401.dart';
import 'package:flutter_app/widgets/error_page_widget/404.dart';
import 'package:flutter_app/widgets/error_page_widget/500.dart';
import 'package:flutter_app/widgets/login_page/router.dart';

class Routes {

  static String home = '/home';
  static String webViewPage = '/webview';

  static String errorPage500 = '/errorPage/500';
  static String errorPage401 = '/errorPage/401';

  static List<IRouter> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint('404 page not found');
        return ErrorPage404();
      });


    router.define(home, handler: Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) => HomePage()));
    router.define(errorPage500, handler: Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) => ErrorPage500()));
    router.define(errorPage401, handler: Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) => ErrorPage401()));
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(MeRouter());
    _listRouter.add(OpportunityRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}

abstract class IRouter{
  void initRouter(Router router);
}
