import 'dart:convert';

import 'package:flutter_app/utils/http/base/base_interceptor.dart';
import 'base_response.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/native_imp.dart';
import 'package:dio/dio.dart';

export 'package:dio/dio.dart';

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(BaseInterceptor());
    init();
  }

  void init();
}

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
