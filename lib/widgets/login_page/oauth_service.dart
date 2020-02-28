import 'package:flutter_app/model/oauth_entity_entity.dart';
import 'package:flutter_app/utils/shared_preferences/sp_util.dart';
import 'package:flutter_app/widgets/login_page/oauth_repository.dart';

abstract class IOauthService {
  Future<OAuthEntityEntity> getToken(String code);
  Future<OAuthEntityEntity> refreshToken();
  Future<bool> revokeToken();
}

class OauthService implements IOauthService {
  final OauthRepository _oauthRepository;

  OauthService(this._oauthRepository);

  @override
  Future<OAuthEntityEntity> getToken(String code) async {
    OAuthEntityEntity oauthEntityEntity = await _oauthRepository.getToken(code);
    _updateToken(oauthEntityEntity);
    return oauthEntityEntity;
  }

  @override
  Future<OAuthEntityEntity> refreshToken() async {
    OAuthEntityEntity oauthEntityEntity = await _oauthRepository.refreshToken();
    _updateToken(oauthEntityEntity);
    return oauthEntityEntity;
  }

  @override
  Future<bool> revokeToken() async {
    bool revokeResult = await _oauthRepository.revokeToken();
    if (revokeResult) {
      await _clearToken();
    }
    return revokeResult;
  }

  _updateToken(OAuthEntityEntity oauthEntityEntity) async {
    print('update token ....... ${oauthEntityEntity.accessToken}');
    print('update refreshToken ....... ${oauthEntityEntity.refreshToken}');
    await SpUtil.putString("access_token", oauthEntityEntity.accessToken);
    await SpUtil.putString("refresh_token", oauthEntityEntity.refreshToken);
  }

  _clearToken() async {
    SpUtil.remove("access_token");
    SpUtil.remove("refresh_token");
  }
}

final OauthService oauthService = new OauthService(new OauthRepository());

