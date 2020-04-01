import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/result_data.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    return new ResultData(response.data, true, 200);
  }
}
