import 'package:flutter_app/model/oauth_entity.dart';
import 'package:flutter_app/utils/shared_preferences/sp_util.dart';
import 'package:flutter_app/widgets/login_page/repository/oauth_repository.dart';

abstract class IOauthService {
  Future<OAuthEntity> getToken(String code);
  Future<OAuthEntity> refreshToken();
  Future<bool> revokeToken();
}

class OauthService implements IOauthService {
  final OauthRepository _oauthRepository;

  OauthService(this._oauthRepository);

  @override
  Future<OAuthEntity> getToken(String code) async {
    OAuthEntity oauthEntity = await _oauthRepository.getToken(code);
    _updateToken(oauthEntity);
    return oauthEntity;
  }

  @override
  Future<OAuthEntity> refreshToken() async {
    OAuthEntity oauthEntity = await _oauthRepository.refreshToken();
    _updateToken(oauthEntity);
    return oauthEntity;
  }

  @override
  Future<bool> revokeToken() async {
    bool revokeResult = await _oauthRepository.revokeToken();
    if (revokeResult) {
      await _clearToken();
    }
    return revokeResult;
  }

  _updateToken(OAuthEntity oauthEntity) async {
    print('update token ....... ${oauthEntity.accessToken}');
    print('update refreshToken ....... ${oauthEntity.refreshToken}');
    await SpUtil.putString("access_token", oauthEntity.accessToken);
    await SpUtil.putString("refresh_token", oauthEntity.refreshToken);
  }

  _clearToken() async {
    SpUtil.remove("access_token");
    SpUtil.remove("refresh_token");
  }
}

final OauthService oauthService = new OauthService(new OauthRepository());

