import 'package:flutter_app/entities/user_entity.dart';
import 'package:intl/intl.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['account'] != null) {
		data.account = json['account']?.toString();
	}
	if (json['englishName'] != null) {
		data.englishName = json['englishName']?.toString();
	}
	if (json['chineseName'] != null) {
		data.chineseName = json['chineseName']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if(json['loginDatetime'] != null){
		DateFormat format = new DateFormat("yyyy-MM-dd HH:mm:ss");
		data.loginDatetime = format.parse(json['loginDatetime'].toString());
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['account'] = entity.account;
	data['englishName'] = entity.englishName;
	data['chineseName'] = entity.chineseName;
	data['email'] = entity.email;
	data['title'] = entity.title;
	if (entity.loginDatetime != null) {
    DateFormat format = new DateFormat("yyyy-MM-dd HH:mm:ss");
    data['loginDatetime'] = format.format(entity.loginDatetime);
  }
	return data;
}
