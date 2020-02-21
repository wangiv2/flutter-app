import 'package:dio/dio.dart';

class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    print('HeaderInterceptors ... ');
    options.connectTimeout = 60 * 1000;
    return options;
  }
}
