import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class NavigatorPageWidget extends BasePageWidget{}

abstract class NavigatorPageWidgetState<T extends NavigatorPageWidget> extends BasePageWidgetState<T> {

  bool _isShowLoading = false;
  bool _isShowNodata = false;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(getTitle()),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: Container(
//              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  buildContentWidget(context),
                  _isShowLoading ? _getLoadingWidget() : _getEmptyWidget(),
                  _isShowNodata ? _getNoDataWidget() : _getEmptyWidget(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _getLoadingWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: Colors.black12,
      child: Center(
        child:
        new SpinKitFadingCircle(color: Colors.deepPurple),
      ),
    );
  }

  Widget _getNoDataWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
//      color: Colors.white,
//      width: double.infinity,
//      height: double.infinity,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/ic_empty.png"),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text("暂无数据~",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
              )
            ],
          ),
        ),
      ),
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

  Widget buildContentWidget(BuildContext context);
  String getTitle();
}
