import 'package:flutter_app/model/config_entity.dart';

configEntityFromJson(ConfigEntity data, Map<String, dynamic> json) {
	if (json['env'] != null) {
		data.env = json['env']?.toString();
	}
	if (json['oauthHost'] != null) {
		data.oauthHost = json['oauthHost']?.toString();
	}
	if (json['versionHost'] != null) {
		data.versionHost = json['versionHost']?.toString();
	}
	if (json['JPushAppKey'] != null) {
		data.jPushAppKey = json['JPushAppKey']?.toString();
	}
	if (json['flurry'] != null) {
		data.flurry = new ConfigFlurry().fromJson(json['flurry']);
	}
	if (json['login'] != null) {
		data.login = new ConfigLogin().fromJson(json['login']);
	}
	return data;
}

Map<String, dynamic> configEntityToJson(ConfigEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['env'] = entity.env;
	data['oauthHost'] = entity.oauthHost;
	data['versionHost'] = entity.versionHost;
	data['JPushAppKey'] = entity.jPushAppKey;
	if (entity.flurry != null) {
		data['flurry'] = entity.flurry.toJson();
	}
	if (entity.login != null) {
		data['login'] = entity.login.toJson();
	}
	return data;
}

configFlurryFromJson(ConfigFlurry data, Map<String, dynamic> json) {
	if (json['iosKey'] != null) {
		data.iosKey = json['iosKey']?.toString();
	}
	if (json['androidKey'] != null) {
		data.androidKey = json['androidKey']?.toString();
	}
	return data;
}

Map<String, dynamic> configFlurryToJson(ConfigFlurry entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['iosKey'] = entity.iosKey;
	data['androidKey'] = entity.androidKey;
	return data;
}

configLoginFromJson(ConfigLogin data, Map<String, dynamic> json) {
	if (json['redirectUri'] != null) {
		data.redirectUri = json['redirectUri']?.toString();
	}
	if (json['clientId'] != null) {
		data.clientId = json['clientId']?.toString();
	}
	if (json['clientSecret'] != null) {
		data.clientSecret = json['clientSecret']?.toString();
	}
	return data;
}

Map<String, dynamic> configLoginToJson(ConfigLogin entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['redirectUri'] = entity.redirectUri;
	data['clientId'] = entity.clientId;
	data['clientSecret'] = entity.clientSecret;
	return data;
}