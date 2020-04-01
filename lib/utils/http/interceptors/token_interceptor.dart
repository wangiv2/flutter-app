import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';

class TokenInterceptors extends InterceptorsWrapper {

  @override
  onRequest(RequestOptions options) async {
    var _token = SpUtil.getString("access_token") ?? "";
    options.headers["Authorization"] = 'Bearer ' + _token;
    return options;
  }
}
