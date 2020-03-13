import 'package:flutter_app/entities/profile_entity.dart';
import 'package:flutter_app/entities/oauth_entity.dart';
import 'package:flutter_app/entities/user_entity.dart';
import 'package:flutter_app/entities/version_entity.dart';

profileEntityFromJson(ProfileEntity data, Map<String, dynamic> json) {
	if (json['isFirstLaunch'] != null) {
		data.isFirstLaunch = json['isFirstLaunch'];
	}
	if (json['user'] != null) {
		data.user = new UserEntity().fromJson(json['user']);
	}
	if (json['oauth'] != null) {
		data.oauth = new OAuthEntity().fromJson(json['oauth']);
	}
	if (json['version'] != null) {
		data.version = new VersionEntity().fromJson(json['version']);
	}
	if (json['locale'] != null) {
		data.locale = json['locale']?.toString();
	}
	if (json['theme'] != null) {
		data.theme = json['theme']?.toString();
	}
	return data;
}

Map<String, dynamic> profileEntityToJson(ProfileEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['isFirstLaunch'] = entity.isFirstLaunch;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	if (entity.oauth != null) {
		data['oauth'] = entity.oauth.toJson();
	}
	if (entity.version != null) {
		data['version'] = entity.version.toJson();
	}
	data['locale'] = entity.locale;
	data['theme'] = entity.theme;
	return data;
}
