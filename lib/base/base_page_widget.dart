import 'package:flutter/material.dart';

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

abstract class BaseFunction {
  BuildContext _context;
  void setContextToBaseFunction(State state) {
    _context = state.context;
  }
  double getScreenHeight() {
    return MediaQuery.of(_context).size.height - 100;
  }
  double getScreenWidth() {
    return MediaQuery.of(_context).size.width;
  }
  double getStatusBarHeight() {
    return MediaQuery.of(_context).padding.top;
  }
  void log(Object object) {
    BasePageWidget basePageWidget = _context.widget;
    print("[$basePageWidget] - $object");
  }
}
