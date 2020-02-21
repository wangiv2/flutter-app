import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/exceptions/not_success_exception.dart';
import 'package:flutter_app/utils/http/exceptions/unauthorized_exception.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw NotSuccessException('No Network');
    }
    return options;
  }

  @override
  Future onError(DioError err) {
    if(err.response != null) {
      int statusCode = err.response.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        throw UnAuthorizedException();
      } else {
        throw NotSuccessException(err.response.data['errorMessage']);
      }
    } else {
      throw NotSuccessException(err.message);
    }
  }
}
