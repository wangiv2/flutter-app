import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListPageWidget extends NavigationBarPageWidget {}

abstract class BaseListPageWidgetState<T extends BaseListPageWidget> extends NavigationBarPageWidgetState<T> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // attributes
  bool enableRefresh = false;
  bool enableLoadMore = false;

  // interfaces
  Future onRefresh();
  Future onLoadMore();
  Widget getListView();

  // Internal properties and methods
  bool _isNoData = true;

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
    bool isNoMoreData = await onLoadMore();
    if(mounted) setState(() {});
    isNoMoreData ? _refreshController.loadNoData() : _refreshController.loadComplete();
  }

  Future _refresh() async {
    _isNoData = await onRefresh();
    if (_isNoData) showNoDataWidget();
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: enableRefresh,
        enablePullUp: enableLoadMore && !_isNoData,
        header: WaterDropHeader(
            waterDropColor: Colors.deepPurple,
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
        child: getListView(),
      ),
    );
  }
}
