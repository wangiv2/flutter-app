import 'package:flutter_app/pages/opportunity/entities/opportunity_entity.dart';

opportunityEntityFromJson(OpportunityEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['subTitle'] != null) {
		data.subTitle = json['subTitle']?.toString();
	}
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	if (json['dateTime'] != null) {
		data.dateTime = json['dateTime']?.toString();
	}
	if (json['isApproved'] != null) {
		data.isApproved = json['isApproved'];
	}
	return data;
}

Map<String, dynamic> opportunityEntityToJson(OpportunityEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['subTitle'] = entity.subTitle;
	data['content'] = entity.content;
	data['dateTime'] = entity.dateTime;
	data['isApproved'] = entity.isApproved;
	return data;
}
