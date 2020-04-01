import 'package:fluro/fluro.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_app/widgets/login_page/pages/common_login.dart';
import 'package:flutter_app/widgets/login_page/pages/oauth_login.dart';


class LoginRouter implements IRouter{

  static String commonLogin = '/login/common';
  static String oauthLogin = '/login/oauth';

  @override
  void initRouter(Router router) {
    router.define(commonLogin, handler: Handler(handlerFunc: (_, params) => CommonLoginPage()));
    router.define(oauthLogin, handler: Handler(handlerFunc: (_, params) => OAuthLoginPage()));
  }

}
