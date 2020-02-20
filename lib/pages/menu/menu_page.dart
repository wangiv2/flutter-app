import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';

class MenuPage extends NavigatorPageWidget {
  @override
  String getPageName() => "MenuPage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _MenuPageState();
}

class _MenuPageState extends NavigatorPageWidgetState<MenuPage> {

  @override
  String getTitle() {
    return flutterI18nUtil.translate("homePage.tabTitles.menu");
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.only(left: 5.0, top: 20.0),
        children: <Widget>[
          _buildListItem(flutterI18nUtil.translate("menuPage.opportunity"), Icons.lightbulb_outline, () {}),
          _buildListItem(flutterI18nUtil.translate("menuPage.interaction"), Icons.chat, () {}),
          _buildListItem(flutterI18nUtil.translate("menuPage.contribution"), Icons.access_alarm, () {}),
        ],
      ),
    );
  }

  Widget _buildListItem(String title, IconData iconData, VoidCallback action) {
    final textStyle = new TextStyle(
        color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.w600);

    return new InkWell(
      onTap: action,
      child: new Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 45.0,
              height: 45.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: new BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: new BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: new Icon(iconData, color: Colors.white, size: 24.0),
            ),
            new Text(title, style: textStyle),
            new Expanded(child: new Container()),
            new IconButton(
                icon: new Icon(Icons.chevron_right, color: Colors.black26),
                onPressed: action)
          ],
        ),
      ),
    );
  }
}
