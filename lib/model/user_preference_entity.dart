import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/model/user_entity.dart';

class UserPreferenceEntity with JsonConvert<UserPreferenceEntity> {
	String language;
	UserEntity user;
}
