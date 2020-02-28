import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListPageWidget extends NavigationBarPageWidget {}

abstract class BaseListPageWidgetState<T extends BaseListPageWidget> extends NavigationBarPageWidgetState<T> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await onRefresh();
    if(mounted) setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await onLoading();
    if(mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
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

        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: getListView(),
      ),
    );
  }

  Future onRefresh();
  Future onLoading();
  Widget getListView();

}
