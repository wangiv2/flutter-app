import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/base/base_http.dart';
import 'package:flutter_app/utils/http/base/base_response.dart';
import 'package:flutter_app/utils/http/exceptions/not_success_exception.dart';
import 'package:flutter_app/utils/http/impl/common/error_interceptor.dart';
import 'package:flutter_app/utils/http/impl/common/token_interceptor.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    interceptors
      ..add(ResponseInterceptor())
      ..add(TokenInterceptor())
      ..add(ErrorInterceptor());
  }
}

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      throw NotSuccessException(respData.message);
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => null == message;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMessage'];
    data = json['data'];
  }
}
