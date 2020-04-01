import 'package:flutter_app/generated/json/base/json_convert_content.dart';

class OpportunityEntity with JsonConvert<OpportunityEntity> {
	int id;
	String title;
	String subTitle;
	String content;
	String dateTime;
	bool isApproved = false;
}
