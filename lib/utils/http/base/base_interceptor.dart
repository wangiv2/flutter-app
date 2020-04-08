import 'package:dio/dio.dart';

class BaseInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 1000 * 60;
    options.receiveTimeout = 1000 * 60;

    return options;
  }
}
