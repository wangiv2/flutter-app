import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/exceptions/not_success_exception.dart';
import 'package:flutter_app/utils/http/exceptions/unauthorized_exception.dart';
import 'package:flutter_app/utils/http/http_manager.dart';
import 'package:flutter_app/widgets/login_page/oauth_service.dart';

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
  Future onError(DioError err) async {
    if (err.response != null) {
      int statusCode = err.response.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        try {
          await oauthService.refreshToken();
        } catch (e) {
          throw UnAuthorizedException();
        }

        Dio dio = httpManager.dio;
        var request = err.response.request;
        // repeat
        var response = await dio.request(request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: request,
            onReceiveProgress: request.onReceiveProgress);
        return response;
      } else {
        throw NotSuccessException(err.response.data['errorMessage']);
      }
    } else {
      throw NotSuccessException(err.message);
    }
  }
}
