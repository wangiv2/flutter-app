import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/ui_widgets/loading_widget.dart';
import 'package:flutter_app/widgets/ui_widgets/noData_widget.dart';

abstract class NavigationBarPageWidget extends BasePageWidget{
  NavigationBarPageWidget({Key key}) : super(key: key);
}

abstract class NavigationBarPageWidgetState<T extends NavigationBarPageWidget> extends BasePageWidgetState<T> {

  // interfaces
  Widget buildContentWidget(BuildContext context);
  String getTitle();

  // override event
  List<Widget> getAppBarActions(BuildContext context) {
    return [];
  }

  // Internal properties and methods
  bool _isShowLoading = false;
  bool _isShowNodata = false;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(getTitle()),
        centerTitle: true,
        actions: getAppBarActions(context),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: Container(
//              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  buildContentWidget(context),
                  _isShowLoading ? LoadingWidget() : _getEmptyWidget(),
                  _isShowNodata ? NoDataWidget() : _getEmptyWidget(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _getEmptyWidget() {
    return Container(
      width: 0,
      height: 0,
    );
  }

  void showLoadingWidget() {
    _isShowLoading = true;
    setState(() {});
  }

  void hideLoadingWidget() {
    _isShowLoading = false;
    setState(() {});
  }

  void showNoDataWidget() {
    _isShowNodata = true;
    setState(() {});
  }

  void hideNoDataWidget() {
    _isShowNodata = false;
    setState(() {});
  }
}
