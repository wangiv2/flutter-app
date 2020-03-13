import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/generated/json/base/json_filed.dart';

class UserEntity with JsonConvert<UserEntity> {
  String account;
  String englishName;
  String chineseName;
  String email;
  String title;
  @JSONField(format: "yyyy-MM-dd HH:mm:ss")
  DateTime loginDatetime;

  UserEntity({
    String account,
    String englishName,
    String chineseName,
    String email,
    String title,
  }){
		this.account = account;
		this.englishName = englishName;
		this.chineseName = chineseName;
		this.email = email;
		this.title = title;
	}
}
