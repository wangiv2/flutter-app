import 'package:fluro/fluro.dart';
import 'package:flutter_app/generated/json/opportunity_entity_helper.dart';
import 'package:flutter_app/pages/opportunity/entities/opportunity_entity.dart';
import 'package:flutter_app/pages/opportunity/pages/opportunity_detail_page.dart';
import 'package:flutter_app/pages/opportunity/pages/opportunity_list_page.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/routers/routers.dart';


class OpportunityRouter implements IRouter{

  static String listPage = '/opportunity/list';
  static String detailPage = '/opportunity/detail';

  @override
  void initRouter(Router router) {
    router.define(listPage, handler: Handler(handlerFunc: (_, params) => OpportunityListPage()));
    router.define(detailPage, handler: Handler(handlerFunc: (_, params) {
      OpportunityEntity opportunity = new OpportunityEntity();
      opportunityEntityFromJson(opportunity, RouterNavigator.decodeObjectParam(params));
      return OpportunityDetailPage(opportunity: opportunity);
    }));
  }

}
