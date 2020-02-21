import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/http_method.dart';
import 'package:flutter_app/utils/http/interceptors/error_interceptor.dart';
import 'package:flutter_app/utils/http/interceptors/header_interceptor.dart';
import 'package:flutter_app/utils/http/interceptors/response_interceptor.dart';
import 'package:flutter_app/utils/http/interceptors/token_interceptor.dart';
import 'package:flutter_app/utils/http/result_data.dart';

class HttpManager {
  Dio _dio = new Dio();
  CancelToken _token = CancelToken();

  HttpManager() {
    _dio.interceptors
      ..add(LogInterceptor())
      ..add(HeaderInterceptors())
      ..add(TokenInterceptors())
      ..add(ErrorInterceptors())
      ..add(ResponseInterceptor());
  }

  Future<ResultData> netFetch(String method, String url, {
    data,
    Options option
  }) async {

    if (option != null) {
      option.method = method;
    } else {
      option = new Options(method: method);
    }

    Response response;
    if (method == Method.GET) {
      response = await _dio.request(url, queryParameters: data, options: option, cancelToken: _token);
    } else {
      response = await _dio.request(url, data: data, options: option, cancelToken: _token);
    }

    return response.data;
  }

  cancelRequest() {
    _token.cancel("cancelled");
  }
}

final HttpManager httpManager = new HttpManager();
