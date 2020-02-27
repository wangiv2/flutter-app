import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListPageWidget extends NavigationBarPageWidget {}

abstract class BaseListPageWidgetState<T extends BaseListPageWidget> extends NavigationBarPageWidgetState<T> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await onRefresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await onLoading();
    if(mounted)
      setState(() {});
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
            complete: Text("刷新数据完毕！"),
            failed: Text("刷新数据失败！"),
        ),
        footer: ClassicFooter(
            canLoadingText: "松开加载",
            loadingText: "正在加载...",
            failedText: "加载数据失败！",
            noDataText: "没有更多数据！",

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
