import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/base/base_http.dart';
import 'package:flutter_app/utils/http/base/base_response.dart';
import 'package:flutter_app/utils/http/exceptions/not_success_exception.dart';

final Http notificationHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    interceptors..add(ResponseInterceptor());
  }
}

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    var respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return response;
    } else {
      throw NotSuccessException(respData.message);
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => data != null;

  ResponseData.fromJson(Map<String, dynamic> json) {
    data = json;
  }
}
