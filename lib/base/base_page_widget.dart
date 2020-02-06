import 'package:flutter/material.dart';

import 'base_function.dart';

abstract class BasePageWidget extends StatefulWidget {
  @override
  BasePageWidgetState createState() {
    return getState();
  }

  BasePageWidgetState getState();
  String getPageName();
}

abstract class BasePageWidgetState<T extends BasePageWidget> extends State<T>
    with WidgetsBindingObserver, BaseFunction {
  Object pageParams;

  void getPageParams() {
    if (pageParams == null) {
      pageParams = ModalRoute.of(context).settings.arguments;
    }
  }

  @override
  void initState() {
    setContextToBaseFunction(this);
    WidgetsBinding.instance.addObserver(this);
    log("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("build");
    getPageParams();
    return Scaffold(
      appBar: AppBar(
        title: new Text(getTitle()),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: getScreenWidth(),
              height: getScreenHeight(),
              color: Colors.white, // background color
              child: Stack(
                children: <Widget>[buildWidget(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
//    HttpManager.cancelHttp(getWidgetName());
    log("dispose");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
//    //此处可以拓展 是不是从前台回到后台
//    if (state == AppLifecycleState.resumed) {
//      //on resume
//      if (NavigatorManger().isTopPage(this)) {
//        onForeground();
//        onResume();
//      }
//    } else if (state == AppLifecycleState.paused) {
//      //onpause
//      if (NavigatorManger().isTopPage(this)) {
//        onBackground();
//        onPause();
//      }
//    }
    super.didChangeAppLifecycleState(state);
  }

  Widget buildWidget(BuildContext context);
  String getTitle();
}
