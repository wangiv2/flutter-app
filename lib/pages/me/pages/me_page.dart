import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/me/router.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';

class MePage extends NavigationBarPageWidget {
  @override
  String getPageName() => "MePage";

  @override
  NavigationBarPageWidgetState<NavigationBarPageWidget> getState() => _MePageState();

}

class _MePageState extends NavigationBarPageWidgetState<MePage> {
  @override
  String getTitle() {
    return flutterI18nUtil.translate("homePage.tabTitles.me");
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildListItem(flutterI18nUtil.translate("mePage.language"), () {
          RouterNavigator.push(context, MeRouter.languagePage);
        }),
        Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                child: Text(flutterI18nUtil.translate("mePage.logout")),
                minWidth: screenUtil.screenWidth - 100,
                textColor: Colors.white,
                color: Colors.deepPurple,
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListItem(String title, VoidCallback action) {
    return ListTile(
      title: Text(
        title,
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.black26),
      onTap: action,
    );
  }
}