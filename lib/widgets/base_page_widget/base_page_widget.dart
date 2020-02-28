import 'package:flutter/material.dart';
import 'package:flutter_app/routers/router.dart';
import 'package:flutter_app/utils/index.dart';

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
  bool _onResumed = false;
  bool _onPause = false;

  /* widget state lifecycle */
  @override
  void initState() {
    initBaseFunction(this);
    RouterManager().addWidget(this.widget);
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
      if (RouterManager().isTopPage(this.widget)) {
        _onResumed = true;
        if (pageParams == null) {
          pageParams = ModalRoute.of(context).settings.arguments;
        }
        onResume();
      }
    }
    return buildWidget(context);
  }

  @override
  void deactivate() {
    if (RouterManager().isSecondTop(this.widget)) {
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (RouterManager().isTopPage(this.widget)) {
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
    RouterManager().removeWidget(this.widget);
    // cancel http request
//    HttpManager.cancelHttp(getWidgetName());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //on resume
      if (RouterManager().isTopPage(this.widget)) {
        onForeground();
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      //onpause
      if (RouterManager().isTopPage(this.widget)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  /* page lifecycle define, can be overridden */
  void onCreate() {
    log("onCreate");
  }
  void onResume() {
    log("onResume");
  }
  void onPause() {
    log("onPause");
  }
  void onBackground() {
    log("onBackground");
  }
  void onForeground() {
    log("onForeground");
  }
  void onDestroy() {
    log("onDestroy");
  }

  /* interfaces */
  Widget buildWidget(BuildContext context);

}
