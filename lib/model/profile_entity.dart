import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/model/oauth_entity.dart';
import 'package:flutter_app/model/user_entity.dart';
import 'package:flutter_app/model/version.dart';

class ProfileEntity with JsonConvert<ProfileEntity> {
	bool isFirstLaunch = true;
	UserEntity user;
	OAuthEntity oauth;
	VersionEntity version;
	String locale;
	String theme;
}

