import 'package:flutter/material.dart';
import 'package:flutter_app/common/funs.dart';
import 'package:flutter_app/res/app_colors.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListPageWidget extends NavigationBarPageWidget {}

abstract class BaseListPageWidgetState<T extends BaseListPageWidget> extends NavigationBarPageWidgetState<T> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // attributes
  bool enableRefresh = false;
  bool enableLoadMore = false;

  // interfaces
  Future loadData({int index = 0});
  Widget buildItem(dynamic item);
  String getDetailPageRouter();

  // Internal properties and methods
  bool _isNoData = true;
  int _selectedIndex = -1;
  List<dynamic> _list = [];

  @override
  void onCreate() async {
    super.onCreate();
    showLoadingWidget();
    await _refresh();
    hideLoadingWidget();
  }

  void _onRefresh() async {
    hideNoDataWidget();
    await _refresh();
    if(mounted) setState(() {});
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  void _onLoading() async {
    List<dynamic> list = await loadData(index: _list.length);
    _list.addAll(list);
    bool isNoMoreData = list.length == 0;
    if(mounted) setState(() {});
    isNoMoreData ? _refreshController.loadNoData() : _refreshController.loadComplete();
  }

  Future _refresh() async {
    _list.clear();
    List<dynamic> list = await loadData();
    _list.addAll(list);
    _isNoData = list.length == 0;
    if (_isNoData) showNoDataWidget();
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: enableRefresh,
        enablePullUp: enableLoadMore && !_isNoData,
        header: WaterDropHeader(
            waterDropColor: Funs.isDarkTheme() ? AppColors.dark_app_main : AppColors.app_main,
            complete: Text(flutterI18nUtil.translate("common.list.pullDownRefresh.complete")),
            failed: Text(flutterI18nUtil.translate("common.list.pullDownRefresh.failed")),
        ),
        footer: ClassicFooter(
            idleText: flutterI18nUtil.translate("common.list.pullUpLoadMore.idle"),
            canLoadingText: flutterI18nUtil.translate("common.list.pullUpLoadMore.releaseToLoad"),
            loadingText: flutterI18nUtil.translate("common.list.pullUpLoadMore.loading"),
            failedText: flutterI18nUtil.translate("common.list.pullUpLoadMore.failed"),
            noDataText: flutterI18nUtil.translate("common.list.pullUpLoadMore.noData"),
            loadStyle: LoadStyle.ShowWhenLoading,
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) {
            return GestureDetector(
              child: buildItem(_list[i]),
              onTap: () {
                _selectedIndex = i;
                String param = RouterNavigator.encodeObjectParam(_list[i].toJson());
                RouterNavigator.pushResult(context, getDetailPageRouter(), (data) {
                  consoleLog('_selectedIndex: $_selectedIndex');
                  if (_selectedIndex != -1) {
                    _list[_selectedIndex] = data;
                    setState(() {});
                  }
                  _selectedIndex = -1;
                }, param:param);
              },
            );
          },
          itemCount: _list.length,
        ),
      ),
    );
  }
}
