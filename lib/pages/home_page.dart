import 'package:flutter/material.dart';
import 'package:flutter_app/base/base_page_widget.dart';
import 'package:flutter_app/pages/me/language_list_page.dart';
import 'package:flutter_app/router.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class HomePage extends BasePageWidget {
  @override
  String getPageName() {
    return "HomePage";
  }

  @override
  BasePageWidgetState<BasePageWidget> getState() {
    return _HomePageState();
  }

}

class _HomePageState extends BasePageWidgetState<HomePage> {
  int _counter = 0;

  void _incrementCounter () async {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(FlutterI18n.plural(context, "homePage.clicked.times", _counter)),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
          MaterialButton(
            child: Text('Increment Counter'),
            color: Colors.white,
            onPressed: () async {
              _incrementCounter();
            },
          ),
          MaterialButton(
            child: Text('Go to Language List'),
            color: Colors.white,
            onPressed: () async {
              Router.pushPage(context, LanguageListPage());
            },
          ),
        ],
      ),
    );
  }

  @override
  String getTitle() {
    return FlutterI18n.translate(context, "homePage.title");
  }
}
