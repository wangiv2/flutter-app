import 'package:dio/dio.dart';

class TokenInterceptors extends InterceptorsWrapper {

  @override
  onRequest(RequestOptions options) async {
    print('TokenInterceptors ... ');
    // TODO: get token
    var _token = "null";
    if (_token != null) {
      options.headers["Authorization"] = 'Bearer ' + _token;
    }
    return options;
  }
}
