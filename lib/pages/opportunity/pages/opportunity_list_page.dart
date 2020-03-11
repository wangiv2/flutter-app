import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/opportunity/model/opportunity_entity.dart';
import 'package:flutter_app/pages/opportunity/repository/opportunity_repo.dart';
import 'package:flutter_app/pages/opportunity/router.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/widgets/base_page_widget/list_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/search_page_widget/common_search_delegate.dart';
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
    await _getData();
    hideLoadingWidget();
  }

  @override
  Widget getListView() {
    return ListView.builder(
      itemBuilder: (c, i) => getListItem(items[i]),
      itemExtent: 100.0,
      itemCount: items.length,
    );
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

  @override
  Future onRefresh() async {
    hideNoDataWidget();
    return await _getData();
  }

  @override
  Future onLoadMore() async {
    return await _getData(index: items.length);
  }

  Widget getListItem(OpportunityEntity item) {
    return ListTile(
      title: Text(item.title),
      trailing: new Icon(Icons.chevron_right, color: Colors.black26),
      onTap: () {
        String param = RouterNavigator.encodeObjectParam(item.toJson());
//            RouterNavigator.push(context, OpportunityRouter.detailPage, param: param);
        RouterNavigator.pushResult(context, OpportunityRouter.detailPage, (data) {
          OpportunityEntity opportunity = data;
          consoleLog("return data: ${opportunity.content}");
        }, param:param);
      },
    );
  }

  Future _getData({int index = 0}) async {
    return OpportunityRepo.getList(index).then((list) {
      if (index == 0) {
        items.clear();
      }
      items.addAll(list);
      if (index == 0 && items.length == 0) {
        showNoDataWidget();
      }
      return list.length == 0;
    });
  }

  void gotoSearchPage() {
    consoleLog("gotoSearchPage");
    List<String> items = [
      '面试',
      'Studio3',
      '动画dfsfds',
      '自定义View',
      '性能优化',
      'gradle',
      'Camera',
      '代码混淆 安全',
      '逆向加固'
    ];
    showSearchPage(
        context: context,
        delegate: CommonSearchDelegate(
          suggestionItems: items,
          onSearch: (query) async {
            consoleLog('onSearch: $query');
            return OpportunityRepo.getList(0);
          },
          buildResultItem: (BuildContext context, Object item) {
            OpportunityEntity opportunity = item;
            return getListItem(opportunity);
          }
        )
    );
  }

}
