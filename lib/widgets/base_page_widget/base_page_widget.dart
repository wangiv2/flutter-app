import 'package:flutter/material.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/utils/index.dart';

abstract class BasePageWidget extends StatefulWidget {

  BasePageWidget({Key key}) : super(key: key);

  @override
  BasePageWidgetState createState() {
    return getState();
  }

  BasePageWidgetState getState();
  String getPageName();
}

abstract class BasePageWidgetState<T extends BasePageWidget> extends State<T>
    with WidgetsBindingObserver, BaseFunction {

  bool _onResumed = false;
  bool _onPause = false;

  /* widget state lifecycle */
  @override
  void initState() {
    initBaseFunction(this);
    RouterNavigator.routerStack.addWidget(this.widget);
    WidgetsBinding.instance.addObserver(this);
    onCreate();
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (!_onResumed) {
      // first load
      if (RouterNavigator.routerStack.isTopPage(this.widget)) {
        _onResumed = true;
        onResume();
      }
    }
    return buildWidget(context);
  }

  @override
  void deactivate() {
    if (RouterNavigator.routerStack.isSecondTop(this.widget)) {
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (RouterNavigator.routerStack.isTopPage(this.widget)) {
      if (!_onPause) {
        onPause();
      }
    }
    super.deactivate();
  }

  @override
  void dispose() {
    onDestroy();
    WidgetsBinding.instance.removeObserver(this);
    _onResumed = false;
    _onPause = false;
    // remove page in router manager
    RouterNavigator.routerStack.removeWidget(this.widget);
    // cancel http request
//    HttpManager.cancelHttp(getWidgetName());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //on resume
      if (RouterNavigator.routerStack.isTopPage(this.widget)) {
        onForeground();
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      //onpause
      if (RouterNavigator.routerStack.isTopPage(this.widget)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  /* page lifecycle define, can be overridden */
  void onCreate() {
    consoleLog("onCreate");
  }
  void onResume() {
    consoleLog("onResume");
  }
  void onPause() {
    consoleLog("onPause");
  }
  void onBackground() {
    consoleLog("onBackground");
  }
  void onForeground() {
    consoleLog("onForeground");
  }
  void onDestroy() {
    consoleLog("onDestroy");
  }

  /* interfaces */
  Widget buildWidget(BuildContext context);

}
