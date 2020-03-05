import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'router_stack.dart';
import 'routers.dart';

class RouterNavigator {

  static Router router;
  static RouterStack routerStack;

  static String _paramKey = "param";

  static init() {
    router = Router();
    routerStack = RouterStack();
    Routes.configureRoutes(router);
  }

  static push(BuildContext context, String path,
      {String param, bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    if(param != null) {
      path = '$path?$_paramKey=$param';
    }
    router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  static pushResult(BuildContext context, String path, Function(Object) function,
      {String param, bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    if(param != null) {
      path = '$path?$_paramKey=$param';
    }
    router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  /// 跳到WebView页
  static goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  static String encodeObjectParam(Map<String, dynamic> param) {
    return jsonEncode(Utf8Encoder().convert(json.encode(param)));
  }

  static dynamic decodeObjectParam(Map<String, List<String>> map) {
    String param = map[_paramKey]?.first;
    var list = List<int>();
    jsonDecode(param).forEach(list.add);
    return json.decode(Utf8Decoder().convert(list));
  }
}
