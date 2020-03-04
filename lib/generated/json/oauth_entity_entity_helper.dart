import 'package:flutter_app/model/oauth_entity_entity.dart';

oAuthEntityEntityFromJson(OAuthEntityEntity data, Map<String, dynamic> json) {
	if (json['access_token'] != null) {
		data.accessToken = json['access_token']?.toString();
	}
	if (json['token_type'] != null) {
		data.tokenType = json['token_type']?.toString();
	}
	if (json['refresh_token'] != null) {
		data.refreshToken = json['refresh_token']?.toString();
	}
	if (json['expires_in'] != null) {
		data.expiresIn = json['expires_in']?.toInt();
	}
	if (json['scope'] != null) {
		data.scope = json['scope']?.toString();
	}
	return data;
}

Map<String, dynamic> oAuthEntityEntityToJson(OAuthEntityEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['access_token'] = entity.accessToken;
	data['token_type'] = entity.tokenType;
	data['refresh_token'] = entity.refreshToken;
	data['expires_in'] = entity.expiresIn;
	data['scope'] = entity.scope;
	return data;
}