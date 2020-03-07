import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/opportunity/model/opportunity_entity.dart';
import 'package:flutter_app/pages/opportunity/router.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/widgets/base_page_widget/list_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/search_page_widget/opportunity_search_page.dart';
import 'package:flutter_app/widgets/search_page_widget/search_page_delegate.dart';

class OpportunityListPage extends BaseListPageWidget{
  @override
  String getPageName() => "OpportunityPage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _OpportunityListPageState();

}

class _OpportunityListPageState extends BaseListPageWidgetState<OpportunityListPage> {

  List<OpportunityEntity> items = [];

  @override
  String getTitle() => flutterI18nUtil.translate("menuPage.opportunity");

  @override
  void onCreate() async {
    super.onCreate();
    showLoadingWidget();
    await _getData(isRefresh: true);
    hideLoadingWidget();
  }

  @override
  Widget getListView() {
    // Card(child: Center(child: Text(items[i])))
    return ListView.builder(
      itemBuilder: (c, i) => ListTile(
        title: Text(items[i].id.toString()),
        trailing: new Icon(Icons.chevron_right, color: Colors.black26),
        onTap: () {
            String param = RouterNavigator.encodeObjectParam(items[i].toJson());
//            RouterNavigator.push(context, OpportunityRouter.detailPage, param: param);
            RouterNavigator.pushResult(context, OpportunityRouter.detailPage, (data) {
              OpportunityEntity opportunity = data;
              consoleLog("return data: ${opportunity.content}");
            }, param:param);
        },
      ),
      itemExtent: 100.0,
      itemCount: items.length,
    );
  }

  @override
  Future onLoading() async {
    return _getData(isLoadMore: true);
  }

  @override
  Future onRefresh() async {
    return _getData(isRefresh: true);
  }

  @override
  List<Widget> getAppBarActions() {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: gotoSearchPage,
      ),
    ];
  }

  Future _getData({bool isRefresh = false, bool isLoadMore = false}) async {
    return Future.delayed(Duration(milliseconds: 1000)).then((_) {
      if (isRefresh) {
        items.clear();
        for(int i=0; i<2; i++) {
          OpportunityEntity opportunity = new OpportunityEntity();
          opportunity.id = i;
          opportunity.content = 'Content $i';
          items.add(opportunity);
        }

      }
      if (isLoadMore) {
        int i = items.length+1;
        OpportunityEntity opportunity = new OpportunityEntity();
        opportunity.id = i;
        opportunity.content = 'Content $i';
        items.add(opportunity);
      }
    });
  }

  void gotoSearchPage() {
    consoleLog("gotoSearchPage");
    showSearchPage(context: context, delegate: OpportunitySearchPage());
  }

}
