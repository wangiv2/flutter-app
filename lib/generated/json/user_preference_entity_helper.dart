import 'package:flutter_app/model/user_preference_entity.dart';
import 'package:flutter_app/model/user_entity.dart';

userPreferenceEntityFromJson(UserPreferenceEntity data, Map<String, dynamic> json) {
	if (json['language'] != null) {
		data.language = json['language']?.toString();
	}
	if (json['user'] != null) {
		data.user = new UserEntity().fromJson(json['user']);
	}
	if (json['isFirstLaunch'] != null) {
		data.isFirstLaunch = json['isFirstLaunch'];
	}
	if (json['isLogin'] != null) {
		data.isLogin = json['isLogin'];
	}
	return data;
}

Map<String, dynamic> userPreferenceEntityToJson(UserPreferenceEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['language'] = entity.language;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	data['isFirstLaunch'] = entity.isFirstLaunch;
	data['isLogin'] = entity.isLogin;
	return data;
}