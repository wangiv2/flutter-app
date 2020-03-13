import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/entities/oauth_entity.dart';
import 'package:flutter_app/entities/user_entity.dart';
import 'package:flutter_app/entities/version_entity.dart';

class ProfileEntity with JsonConvert<ProfileEntity> {
	bool isFirstLaunch = true;
	UserEntity user;
	OAuthEntity oauth;
	VersionEntity version;
	String locale;
	String theme;
}

