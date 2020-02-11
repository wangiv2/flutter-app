import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/generated/json/base/json_filed.dart';

class UserEntity with JsonConvert<UserEntity> {
	int id;
	String account;
	String token;
	String momeny;
	@JSONField(format: "yyyy-MM-dd HH:mm:ss")
	DateTime loginDatetime;
}
