import 'package:fluro/fluro.dart';
import 'package:flutter_app/pages/home/pages/home_page.dart';
import 'package:flutter_app/routers/routers.dart';


class HomeRouter implements IRouter{

  static String homePage = '/home';

  @override
  void initRouter(Router router) {
    router.define(homePage, handler: Handler(handlerFunc: (_, params) => HomePage()));
  }

}
