import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/opportunity/entities/opportunity_entity.dart';
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

  int _selectedIndex = -1;
  List<OpportunityEntity> _items = [];

  @override
  bool get enableRefresh => true;

  @override
  bool get enableLoadMore => true;

  @override
  String getTitle() => flutterI18nUtil.translate("menuPage.opportunity");

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
  Widget getListView() {
    return ListView.builder(
      itemBuilder: (c, i) => _getListItem(_items[i], index:i),
      itemExtent: 100.0,
      itemCount: _items.length,
    );
  }

  Widget _getListItem(OpportunityEntity item, {int index = -1}) {
    return ListTile(
      title: Text(item.title),
      trailing: new Icon(Icons.chevron_right, color: Colors.black26),
      onTap: () {
        _selectedIndex = index;
        String param = RouterNavigator.encodeObjectParam(item.toJson());
//            RouterNavigator.push(context, OpportunityRouter.detailPage, param: param);
        RouterNavigator.pushResult(context, OpportunityRouter.detailPage, (data) {
          consoleLog('_selectedIndex: $_selectedIndex');
          if (_selectedIndex != -1) {
            _items[_selectedIndex] = data;
            setState(() {});
          }
          _selectedIndex = -1;
        }, param:param);
      },
    );
  }

  @override
  Future onRefresh() async {
    return await _getData();
  }

  @override
  Future onLoadMore() async {
    return await _getData(index: _items.length);
  }

  Future _getData({int index = 0}) async {
    return OpportunityRepo.getList(index).then((list) {
      if (index == 0) _items.clear();
      _items.addAll(list);
      return list.length == 0;
    });
  }

  void gotoSearchPage() {
    showSearchPage(
        context: context,
        delegate: CommonSearchDelegate(
          suggestionItems: getHistoryItems(),
          onSearch: (query) async {
            consoleLog('onSearch: $query');
            return OpportunityRepo.getList(0);
          },
          buildResultItem: (BuildContext context, int index, Object item) {
            OpportunityEntity opportunity = item;
            return _getListItem(opportunity);
          }
        )
    );
  }

  List<String> getHistoryItems() {
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
    return items;
  }



}
