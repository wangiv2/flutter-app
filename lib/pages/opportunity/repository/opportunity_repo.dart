import 'package:flutter_app/pages/opportunity/entities/opportunity_entity.dart';

class OpportunityRepo {
  static Future getList(int index) {
    return Future.delayed(Duration(seconds: 1)).then((_) {
      List<OpportunityEntity> list = [];
      if(index > 20) {
        return list;
      }

      for(int i=index; i<index+8; i++) {
        OpportunityEntity opportunity = new OpportunityEntity();
        opportunity.id = i;
        opportunity.title = 'Title $i';
        opportunity.content = 'Content $i';
        list.add(opportunity);
      }
      return list;
    });
  }
}
