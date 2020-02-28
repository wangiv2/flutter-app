import 'package:dio/dio.dart';
import 'package:flutter_app/model/oauth_entity_entity.dart';
import 'package:flutter_app/utils/http/http_manager.dart';
import 'package:flutter_app/utils/http/http_method.dart';
import 'package:flutter_app/utils/shared_preferences/sp_util.dart';

abstract class IOauthRepository {
  Future<OAuthEntityEntity> getToken(String code);

  Future<OAuthEntityEntity> refreshToken();

  Future<bool> revokeToken();
}

class OauthRepository implements IOauthRepository {
  @override
  Future<OAuthEntityEntity> getToken(String code) async {
    var params = {
      "client_id": "6a4e409ea4a4441dbd4c6de60523f35c",
      "client_secret": "523e3e9c500a45af92ab1bb8aca4dbb1",
      "grant_type": "authorization_code",
      "redirect_uri": "http://mobileoauth/easapp",
      "code": code
    };

    var res = await httpManager.netFetch(
        Method.POST, 'https://oauth.oocl.com/oauthserver/oauth/token',
        data: params,
        option: Options(contentType: Headers.formUrlEncodedContentType));
    OAuthEntityEntity oauthResponse = OAuthEntityEntity().fromJson(res.data);
    return oauthResponse;
  }

  @override
  Future<OAuthEntityEntity> refreshToken() async {
    String refreshToken = SpUtil.getString("refresh_token");

    var params = {
      "client_id": "6a4e409ea4a4441dbd4c6de60523f35c",
      "client_secret": "523e3e9c500a45af92ab1bb8aca4dbb1",
      "grant_type": "refresh_token",
      "redirect_uri": "http://mobileoauth/easapp",
      "refresh_token": refreshToken
    };

    var res = await httpManager.netFetch(
        Method.POST, 'https://oauth.oocl.com/oauthserver/oauth/token',
        data: params,
        option: Options(contentType: Headers.formUrlEncodedContentType));
    OAuthEntityEntity oauthResponse = OAuthEntityEntity().fromJson(res.data);

    return oauthResponse;
  }

  @override
  Future<bool> revokeToken() async {
    String accessToken = SpUtil.getString("access_token");

    var params = {
      "client_id": "6a4e409ea4a4441dbd4c6de60523f35c",
      "client_secret": "523e3e9c500a45af92ab1bb8aca4dbb1",
      "access_token": accessToken,
    };

    var res = await httpManager.netFetch(
        Method.POST, 'https://oauth.oocl.com/oauthserver/oauth/token/revoke',
        data: params,
        option: Options(contentType: Headers.formUrlEncodedContentType));

    bool result = res.data.toLowerCase() == 'true';
    print('result ==== $result');
    return result;
  }
}
