import 'package:flutter_app/model/user_entity.dart';
import 'package:intl/intl.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['account'] != null) {
		data.account = json['account']?.toString();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	if (json['momeny'] != null) {
		data.momeny = json['momeny']?.toString();
	}
	if(json['loginDatetime'] != null){
		DateFormat format = new DateFormat("yyyy-MM-dd HH:mm:ss");
		data.loginDatetime = format.parse(json['loginDatetime'].toString());
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['account'] = entity.account;
	data['token'] = entity.token;
	data['momeny'] = entity.momeny;
	if (entity.loginDatetime != null) {
    DateFormat format = new DateFormat("yyyy-MM-dd HH:mm:ss");
    data['loginDatetime'] = format.format(entity.loginDatetime);
  }
	return data;
}
