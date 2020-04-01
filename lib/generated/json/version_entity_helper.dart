import 'package:flutter_app/entities/version_entity.dart';

versionEntityFromJson(VersionEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['description'] != null) {
		data.description = json['description']?.toString();
	}
	return data;
}

Map<String, dynamic> versionEntityToJson(VersionEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['description'] = entity.description;
	return data;
}
