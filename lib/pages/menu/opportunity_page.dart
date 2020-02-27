import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/base_list_page_widget.dart';
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
    await Future.delayed(Duration(seconds: 2)).then((_){
      items.addAll(["1", "2", "3", "4", "5", "6", "7", "8"]);
      hideLoadingWidget();
    });
  }

  @override
  Widget getListView() {
    return ListView.builder(
      itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
      itemExtent: 100.0,
      itemCount: items.length,
    );
  }

  @override
  Future onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    items.add((items.length+1).toString());
  }

  @override
  Future onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

}
