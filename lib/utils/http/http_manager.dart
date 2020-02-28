import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/http_method.dart';
import 'package:flutter_app/utils/http/interceptors/error_interceptor.dart';
import 'package:flutter_app/utils/http/interceptors/header_interceptor.dart';
import 'package:flutter_app/utils/http/interceptors/response_interceptor.dart';
import 'package:flutter_app/utils/http/interceptors/token_interceptor.dart';
import 'package:flutter_app/utils/http/result_data.dart';

class HttpManager {
  Dio _dio;
  Dio get dio => _dio;

  CancelToken _token = CancelToken();

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() => _instance;

  HttpManager._internal() {
    if (_dio == null) {
      print('new dio ....');
      _dio = new Dio();

      _dio.interceptors
        ..add(HeaderInterceptors())
        ..add(TokenInterceptors())
        ..add(ErrorInterceptors())
        ..add(ResponseInterceptor())
        ..add(LogInterceptor());
    }
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
