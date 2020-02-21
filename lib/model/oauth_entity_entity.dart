import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/generated/json/base/json_filed.dart';

class OAuthEntityEntity with JsonConvert<OAuthEntityEntity> {
	@JSONField(name: "access_token")
	String accessToken;
	@JSONField(name: "token_type")
	String tokenType;
	@JSONField(name: "refresh_token")
	String refreshToken;
	@JSONField(name: "expires_in")
	int expiresIn;
	String scope;
}
