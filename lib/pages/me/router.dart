import 'package:fluro/fluro.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_app/widgets/language_list_page/language_list_page.dart';

class MeRouter implements IRouter{

  static String languagePage = '/me/language';

  @override
  void initRouter(Router router) {
    router.define(languagePage, handler: Handler(handlerFunc: (_, params) => LanguageListPage()));
  }

}
