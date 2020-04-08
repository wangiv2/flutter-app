import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/utils/http/exceptions/not_success_exception.dart';
import 'package:flutter_app/utils/http/exceptions/unauthorized_exception.dart';
import 'package:flutter_app/utils/http/impl/common/common_http.dart';
import 'package:flutter_app/widgets/login_page/service/oauth_service.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  bool _isRefresh = false;
  var queue = [];

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
        print('Session Timeout ... ');
        var request = err.response.request;

        if (!_isRefresh) {
          _isRefresh = true;

          try {
            await oauthService.refreshToken();
          } catch (e) {
            throw UnAuthorizedException();
          } finally {
            _isRefresh = false;
          }

          this.queue.forEach((cb) => cb(request));
          this.queue.clear();

          var response = await http.request(request.path,
              data: request.data,
              queryParameters: request.queryParameters,
              cancelToken: request.cancelToken,
              options: request,
              onReceiveProgress: request.onReceiveProgress);
          return response;
        } else {
          Completer completer = new Completer();

          this.queue.add((request) async {
            var response = await http.request(request.path,
                data: request.data,
                queryParameters: request.queryParameters,
                cancelToken: request.cancelToken,
                options: request,
                onReceiveProgress: request.onReceiveProgress);

            return completer.complete(response);
          });

          return completer.future;
        }
      } else {
        throw NotSuccessException(err.response.data['errorMessage']);
      }
    } else {
      throw NotSuccessException(err.message);
    }
  }
}
