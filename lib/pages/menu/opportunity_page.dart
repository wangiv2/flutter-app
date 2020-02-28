import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/menu/opportunity_detail_page.dart';
import 'package:flutter_app/routers/router.dart';
import 'package:flutter_app/widgets/base_page_widget/list_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';

class OpportunityPage extends BaseListPageWidget{
  @override
  String getPageName() => "OpportunityPage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _OpportunityPageState();

}

class _OpportunityPageState extends BaseListPageWidgetState<OpportunityPage> {

  List<String> items = [];

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
        title: Text(items[i]),
        trailing: new Icon(Icons.chevron_right, color: Colors.black26),
        onTap: () {
          Router.pushPage(context, OpportunityDetailPage(), params: items[i]);
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

  Future _getData({bool isRefresh = false, bool isLoadMore = false}) async {
    return Future.delayed(Duration(milliseconds: 1000)).then((_) {
      if (isRefresh) {
        items.clear();
        items.addAll(["1", "2", "3", "4", "5", "6", "7", "8"]);

      }
      if (isLoadMore) {
        items.add((items.length+1).toString());
      }
    });
  }

}
